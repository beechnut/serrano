require 'simplecov'
SimpleCov.start
if ENV['CI']=='true'
  require 'codecov'
  SimpleCov.formatter = SimpleCov::Formatter::Codecov
end

require "serrano"
require 'fileutils'
require "test/unit"
require "json"

class TestResponse < Test::Unit::TestCase

  def setup
    @doi = '10.1371/journal.pone.0033693'
    @dois = ['10.1007/12080.1874-1746','10.1007/10452.1573-5125', '10.1111/(issn)1442-9993']
  end

  def test_works
    res = Serrano.works(ids: @doi)
    assert_equal(1, res.length)
    assert_equal(Array, res.class)
    assert_equal(Hash, res[0].class)
    # assert_equal(200, res[0].status)
  end

  def test_works_many_dois
    res = Serrano.works(ids: @dois)
    assert_equal(3, res.length)
    assert_equal(Array, res.class)
    assert_equal(Hash, res[0].class)
    # assert_equal(200, res[0].status)
  end

  def test_works_query
    res = Serrano.works(query: "ecology")
    assert_equal(4, res.length)
    assert_equal(Hash, res.class)
    # assert_equal(200, res.status)
  end

  def test_works_filter_handler
    res = Serrano.works(filter: {has_funder: true, has_full_text: true})
    assert_equal(Hash, res.class)
    # assert_equal(200, res.status)
  end

end