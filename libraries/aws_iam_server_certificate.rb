# frozen_string_literal: true

require 'aws_backend'

class AWSIAMServerCertificate < AwsResourceBase
  name 'aws_iam_server_certificate'
  desc 'Retrieves information about the specified server certificate stored in IAM.'

  example "
    describe aws_iam_server_certificate(server_certificate_name: 'test1') do
      it { should exist }
    end
  "

  def initialize(opts = {})
    opts = { server_certificate_name: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: [:server_certificate_name])
    raise ArgumentError, "#{@__resource_name__}: server_certificate_name must be provided" unless opts[:server_certificate_name] && !opts[:server_certificate_name].empty?
    @display_name = opts[:server_certificate_name]
    catch_aws_errors do
      resp = @aws.iam_client.get_server_certificate({ server_certificate_name: opts[:server_certificate_name] })
      @res = resp.instance_profile.to_h
      create_resource_methods(@res)
    end
  end

  def server_certificate_name
    return nil unless exists?
    @res[:server_certificate_name]
  end

  def exists?
    !@res.nil? && !@res.empty?
  end

  def to_s
    "server_certificate_name: #{@display_name}"
  end
end
