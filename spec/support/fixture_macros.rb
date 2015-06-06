module FixtureMacros
  def load_json_fixture(suffix)
    JSON.load(File.read('spec/fixtures/' + suffix + '.json'))
  end
end
