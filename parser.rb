class DotParser

  def self.parse(dotfile)
    builder = GraphBuilder.new
    new(builder).parse(dotfile)
    builder.graph
  end

  def parse(dotfile)
    File.open(dotfile) do |f|
      f.each_line do |line|
        edge_from_string line.split('->') if line.match(/->/)
      end
    end
  end

  def initialize(graph_builder)
    @builder = graph_builder
  end

  def edge_from_string(line)
    parent = line[0].strip
    child = line[1].strip.tr(';', '')
    @builder.add_edge parent, child
  end

  def attr_from_string(line)
  end

end

class GraphBuilder

  def initialize
    @graph = {}
    @attrs = {}
  end

  def add_edge(parent, child)
    if @graph[parent].nil?
      @graph[parent] = [child]
    else
      @graph[parent] += [child]
    end
  end

  def add_attr(node, attr)

  end

  def graph
    @graph
  end

end


puts DotParser.parse('sample.dot').inspect
