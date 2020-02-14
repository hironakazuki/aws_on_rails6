class DeleteUnreferencedBlobJob < ApplicationJob
  sidekiq_options queue: :default, retry: 3
  require 'aws-sdk-s3' 

  def perform(*args)
    blob_ids = ActiveStorage::Blob.pluck(:id)
    _blob_ids = ActiveStorage::Attachment.pluck(:blob_id).uniq
    unreferenced_blob_ids = blob_ids - _blob_ids
    if Rails.env.production?
      s3 = Aws::S3::Resource.new(
        region: 'ap-northeast-1',
        credentials: Aws::Credentials.new(
          Rails.application.credentials.dig(:aws, :access_key_id),  # S3用アクセスキー
          Rails.application.credentials.dig(:aws, :secret_access_key)  # S3用シークレットアクセスキー
        )
      )
      bucket = s3.bucket('aws-on-rails6')
      unreferenced_blob_ids.each do |id|
        s3_file_key = ActiveStorage::Blob.find(id).key
        bucket.object(s3_file_key).delete
        bucket.objects({prefix: "variants/#{s3_file_key}"}).batch_delete!
      end
    end

    ActiveStorage::Blob.where(id: unreferenced_blob_ids).delete_all
  end
end