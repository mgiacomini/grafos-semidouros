class DotWriter
  def initialize(graph={}, attrs={})
    @graph = graph
    @attrs = attrs
  end

  def to_dot(dotfile=STDOUT)
    f = File.open(dotfile, 'w+') if !(dotfile.class == STDOUT.class)
    f = dotfile if dotfile.class == STDOUT.class
    f.puts 'strict digraph exemplo {'
    write_attrs f
    write_edges f
    f.puts '}'
    f.close if !(dotfile.class == STDOUT.class)
  end

  private
  def write_attrs(f)
    @attrs.each do |node, attrs|
      b = Hash.new(0)
      # iterate over the array, counting duplicate entries
      attrs.each do |v|
        b[v] += 1
      end

      attrs_list = b.map do |k, v|
        "#{k}=#{v}"
      end

      f.puts "  #{node} [#{attrs_list.join(',')}];"
    end
  end

  def write_edges(f)
    @graph.each do |parent, childs|
      childs.each do |child|
        f.puts "  #{parent} -> #{child};"
      end
    end
  end
end


class DotParser

  def self.parse(dotfile, builder)
    new(builder).parse(dotfile)
    builder.graph
  end

  def parse(dotfile)
    File.open(dotfile) do |f|
      f.each_line do |line|
        edge_from_string line.split('->') if line.match(/->/)
        attr_from_string line if line.match(/=/)
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
    splited = line.strip.split('[')
    node = splited[0].strip
    attr_splited = splited[1].split('=')
    attr_name = attr_splited[0]
    attr_count = attr_splited[1].tr('];', '')

    attr_count.to_i.times.each do
      @builder.add_attr(node, attr_name)
    end

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
    if @attrs[node].nil?
      @attrs[node] = [attr]
    else
      @attrs[node] += [attr]
    end
  end

  def graph
    @graph
  end

  def attrs
    @attrs
  end
end
