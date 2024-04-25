# frozen_string_literal: true

module Langchain::Tool
  class Eth < Base
    #
    # Tool that adds the capability to interact with the Ethereum blockchain
    #
    # Gem requirements: gem "eth"
    #
    NAME = 'eth'
    ANNOTATIONS_PATH = Langchain.root.join("./langchain/tool/#{NAME}/#{NAME}.json").to_path

    attr_reader :client

    def initialize(api_key:)
      depends_on 'eth'
      require 'eth'

      @client = ::Eth::Client.create "https://mainnet.infura.io/v3/#{api_key}"
    end

    # Executes resolve ENS name record and returns the address
    # @param input [String] ENS name
    # @return [String] Address
    def execute(input:)
      Langchain.logger.info("Executing \"#{input}\"", for: self.class)

      client.resolve_ens(input)
    end
  end
end

