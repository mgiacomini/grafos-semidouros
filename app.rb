require_relative 'parser'

class Graph

  def initialize(graph, attrs)
    @graph = graph
    @attrs = attrs
  end

  def create(root)
    queue = [root]
    while queue.size > 0
      current = queue.shift

      unless has_attrs?(current)
        childs = @graph[current] # ex: for 'A' => ['B', 'C']
        unless childs.nil?
          childs.each do |child| # testar se funciona: se current tem filhos sem attributos, enfileirar todos os filhos de current sem atributos
            if has_attrs?(child)
              child_attrs = @attrs[child]
              child_attrs.each { |at| @attrs[current].push at }
            else
              queue.push child
            end
          end
          queue.push current
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

App.run ARGV.first