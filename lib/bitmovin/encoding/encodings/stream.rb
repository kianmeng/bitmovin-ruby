module Bitmovin::Encoding::Encodings
  class Stream < Bitmovin::Resource
    attr_accessor :encoding_id
    attr_accessor :id

    def initialize(encoding_id, hash)
      hsh = ActiveSupport::HashWithIndifferentAccess.new(underscore_hash(hash))
      @encoding_id = encoding_id
      @resource_path = File.join("/v1/encoding/encodings/", encoding_id, "streams")
      super(hash)
      @outputs = hsh[:outputs].map { |output| StreamOutput.new(@encoding_id, @id, output) }
      @input_streams = hsh[:input_streams].map { |input| StreamInput.new(@encoding_id, @id, input) }
    end

    attr_accessor :name, :description, :created_at, :modified_at
    attr_accessor :codec_config_id

    def input_streams
      @input_streams
    end

    def build_input_stream(opts = {})
      input = StreamInput.new(@encoding_id, @id, opts)
      @input_streams << input
      input
    end

    def outputs
      @outputs
    end

    def build_output(opts = {})
      output = StreamOutput.new(@encoding_id, @id, opts)
      @outputs << output
      output
    end

    def codec_configuration=(configuration)
    end
    def codec_configuration
    end
  end
end
