# -*- encoding: utf-8 -*-
# RSquared-Message Gemspec file
# Copyright 2013 Nicolas Doye

# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at

#     http://www.apache.org/licenses/LICENSE-2.0

# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

$:.push File.expand_path("../lib", __FILE__)
require 'rsquared/message/version'

Gem::Specification.new do |s|
  s.name        = 'rsquared-message'
  s.version     = RSquared::Message::VERSION
  s.platform    = Gem::Platform::RUBY
  s.date        = '2013-09-14'
  s.summary     = "Raw DNS Message Objects"
  s.description = "An Object Oriented way to create and parse Raw DNS Messages. Part of the R Squared DNS Server."
  s.authors     = ["Nic Doye"]
  s.email       = 'nic@worldofnic.org'
  s.files       = `git ls-files`.split("\n")
  s.homepage    = 'http://rsquared.io'
  s.license     = 'Apache License, v2.0'
  s.require_paths = ["lib"]
end
