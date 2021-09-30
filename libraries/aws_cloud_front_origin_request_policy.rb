# frozen_string_literal: true

require 'aws_backend'

class AWSCloudFrontOriginRequestPolicy < AwsResourceBase
  name 'aws_cloud_front_origin_request_policy'
  desc 'Describes an origin request policy .'

  example "
    describe aws_cloud_front_origin_request_policy(id: 'test1') do
      it { should exist }
    end
  "

  def initialize(opts = {})
    opts = { id: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: [:id])

    raise ArgumentError, "#{@__resource_name__}: id must be provided" unless opts[:id] && !opts[:id].empty?
    @display_name = opts[:id]
    resp = @aws.cloudfront_client.get_origin_request_policy({ id: opts[:id] })
    @origin_request_policy= resp.origin_request_policy.to_h
    create_resource_methods(@origin_request_policy)
  end

  def id
    return nil unless exists?
    @origin_request_policy[:id]
  end

  def exists?
    !@origin_request_policy.nil? && !@origin_request_policy.empty?
  end

  def to_s
    "Origin request policy ID: #{@display_name}"
  end
end
