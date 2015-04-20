require_relative '../lib/Robot.rb'

describe ToyRobot do
	it 'runs test case a' do
		file = File.dirname(__FILE__) + '/' + 'test_a.txt'
		expect(ToyRobot.new.fileinput(file)).to eq("Output: 0,1,NORTH")
	end

	it 'runs test case b' do
		file = File.dirname(__FILE__) + '/' + 'test_b.txt'
		expect(ToyRobot.new.fileinput(file)).to eq("Output: 0,0,WEST")
	end

	it 'runs test case c' do
		file = File.dirname(__FILE__) + '/' + 'test_c.txt'
		expect(ToyRobot.new.fileinput(file)).to eq("Output: 3,3,NORTH")
	end
end