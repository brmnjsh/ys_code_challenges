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
  dist = {}
  prev = {}
  q = []

  $graph.each do |k, _|
    dist[k] = $INFINITY
    prev[k] = nil
    q.push(k)
  end

  dist[source] = 0

  while q.size > 0 do
    u = min_distance(q, dist)
    break if dist[u] == $INFINITY

    q.delete(u)

    $graph[u].keys.each do |v|
      alt = dist[u] + $graph[u][v]

      if alt < dist[v]
        dist[v] = alt
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


dijkstra('Vathlo')





