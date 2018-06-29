#Djikstra's algorithm

$INFINITY = 1 << 64
$graph = {
  'Argo' => {
    'Xan' => 24,
    'Erkol' => 71
  },
  'Xan' => {
    'Argo' => 24,
    'Kandor' => 103,
    'Bokos' => 59
  },
  'Vathlo' => {
    'Kryptonopolis' => 141,
    'Erkol' => 101,
    'Bokos' => 65
  },
  'Kryptonopolis' => {
    'Erkol' => 169,
    'Vathlo' => 141
  },
  'Erkol' => {
    'Bokos' => 134,
    'Argo' => 71,
    'Vathlo' => 101,
    'Kryptonopolis' => 169
  },
  'Kandor' => {
    'Xan' => 103
  },
  'Bokos' => {
    'Xan' => 59,
    'Vathlo' => 65,
    'Erkol' => 134
  }
}


def dijkstra(source)
  dist = {} #distance in reference to source
  prev = {} #the previous object in the shortest path
  q = [] #queue of all the nodes in graph

  # set details for distance and previous
  # add each node to queue
  $graph.each do |k, _|
    dist[k] = $INFINITY
    prev[k] = nil
    q.push(k)
  end

  # the source has a 0 distance to itself....MUST SET
  dist[source] = 0

  # exit condition once the queue is empty
  while q.size > 0 do
    #current smallest distance in queue
    u = min_distance(q, dist)
    # if the distance hasn't be set break
    # which means it selects the source
    # this is why setting dist[source] is important
    break if dist[u] == $INFINITY

    # remove current selected item from queue
    q.delete(u)

    # iteratet through each node in graph
    $graph[u].keys.each do |v|
      # get distance of selected node from queue
      # add the distance of the iterated path to current distance distance
      alt = dist[u] + $graph[u][v]

      # if new distance is less than current set distance for path in current node
      if alt < dist[v]
        # set the new distance
        dist[v] = alt
        # set the previous item (the root of these paths)
        prev[v] = u
      end
    end
  end

  [dist, prev]
end

def min_distance(q, dist)
  min = nil

  q.each do |i|
    if min == nil || dist[i] < dist[min]
      min = i
    end
  end

  min
end

def generate_path(start_node, next_node, node_relationships, result)
  if next_node == start_node
    start_node + '-' + result
  else
    generate_path(start_node, node_relationships[next_node], node_relationships, next_node + '-' + result)
  end
end

def run(start, finish)
  dist, node_relationships = dijkstra(start)
  path = generate_path(start, node_relationships[finish], node_relationships, finish)
  final_distance = dist[finish]
  [path, final_distance.to_s + ' miles']
end

run('Vathlo', 'Xan')
run('Kryptonopolis', 'Kandor')
run('Bokos', 'Argo')
run('Vathlo', 'Kryptonopolis')
run('Kandor', 'Xan')
run('Vathlo', 'Argo')
run('Argo', 'Vathlo')
