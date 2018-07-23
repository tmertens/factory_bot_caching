# The MIT License (MIT)
#
# Copyright (c) 2017-2018 Avant
#
# Author Tim Mertens
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

require_relative 'config'

module FactoryBotCaching
  class << self
    def configuration
      @configuration ||= Config.new
    end

    def configure(&block)
      raise ArgumentError, 'You must supply a block!' unless block_given?
      yield configuration
    end

    def enabled?
      configuration.factory_caching_enabled?
    end

    def without_caching(&block)
      original_caching_value = configuration.factory_caching_enabled?
      configuration.disable_factory_caching
      block.call
    ensure
      configuration.enable_factory_caching if original_caching_value
    end
  end
end