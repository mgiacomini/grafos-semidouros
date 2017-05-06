class Graph

  def initialize(graph, attrs)
    @graph = graph
    @attrs = attrs
  end

  def create(root)
    queue = [root]
    while queue.size > 0
      current = queue.shift

      if has_attrs?(current)
        next
      else
        childs = @graph[current] # ex: for 'A' => ['B', 'C']
        unless childs.nil?
          childs.each do |child|
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


graph = {
    'A' => ['B', 'C'],
    'B' => ['X', 'Y', 'Z'],
    'C' => ['Y', 'Z']
}

attrs = {
    'X' => ['FIM'],
    'Y' => ['FIM'],
    'Z' => ['OUTRO']
}

g = Graph.new(graph, attrs)
g.create('A')

p attrs
