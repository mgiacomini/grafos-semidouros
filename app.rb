require_relative 'parser'

class Graph

  def initialize(graph, attrs)
    @graph = graph
    @attrs = attrs
  end

  def create(root)
    stack = [root]
    while stack.size > 0
      current = stack.pop
      parent_pushed = false
      childs = @graph[current] # ex: for 'A' => ['B', 'C']
      childs.each do |child|

        if has_attrs?(child)
          child_attrs = @attrs[child]
          child_attrs.each { |at| @attrs[current].push at }
        else
          unless parent_pushed
            stack.push current
            parent_pushed = true
          end
          @attrs[current].clear if has_attrs?(current)
          stack.push child
        end
      end
    end
  end

  def has_attrs?(node)
    @attrs[node] = [] if @attrs[node].nil?
    @attrs[node].any?
  end

end

class App
  def self.run(dotfile)
    builder = GraphBuilder.new

    #puts '=== parsing graph'
    graph = DotParser.parse(dotfile, builder)
    attrs = builder.attrs

    #puts '=== transforming'
    #puts graph.inspect
    #puts attrs.inspect
    g = Graph.new(graph, attrs)
    g.create('A')

    #puts '-> attributes'
    #puts attrs.inspect

    writer = DotWriter.new graph, attrs
    #puts '--> writing dot file'
    writer.to_dot
  end

end