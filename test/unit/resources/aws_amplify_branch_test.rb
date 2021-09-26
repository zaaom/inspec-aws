require 'helper'
require 'aws_amplify_branch'
require 'aws-sdk-core'

class AWSAmplifyBranchConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSAmplifyBranch.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSAmplifyBranch.new(app_id: '', branch_name: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSAmplifyBranch.new(unexpected: 9) }
  end
end

class AWSAmplifyBranchSuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :get_branch
    mock_data = {}
    mock_data[:branch_arn] = 'test1'
    mock_data[:branch_name] = 'test1'
    mock_data[:description] = 'test1'
    data[:data] = [mock_data]
    data[:client] = Aws::Amplify::Client
    @resp = AWSAmplifyBranch.new(app_id: 'test1', branch_name: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_branch_exists
    assert @resp.exists?
  end

  def test_branch_arn
    assert_equal(@resp.branch_arn, 'test1')
  end

  def test_branch_name
    assert_equal(@resp.branch_name, 'test1')
  end

  def test_description
    assert_equal(@resp.description, 'test1')
  end
end

