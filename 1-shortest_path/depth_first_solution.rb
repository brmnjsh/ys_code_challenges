# Depth first search

$distances = [
  {'Argo-Xan' => 24},
  {'Argo-Erkol' => 71},
  {'Xan-Kandor' => 103},
  {'Xan-Bokos' => 59},
  {'Vathlo-Kryptonopolis' => 141},
  {'Vathlo-Erkol' => 101},
  {'Vathlo-Bokos' => 65},
  {'Kryptonopolis-Erkol' => 169},
  {'Erkol-Bokos' => 134}
]

def run(start, dest)
  # get all the path nodes that have the start item in them
  starts = $distances.map do |d|
    d if d.keys.first.include? start
  end.compact

  # get all the paths
  paths = starts.map do |s|
    get_shortest_path(s, start, dest, 0, start)
  end

  res = nil

  # find the shortest path
  paths.each do |p|
    #puts p
    res = p if res == nil || p[1] < res[1]
  end

  [res[0], res[1].to_s + ' miles']
end

def get_shortest_path(start, point, dest, total, path)
  total = total + start.values.first

  #if the destination is in the path node
  if destination_exists?(start, dest)
    new_path = path + '-' + dest
    return [new_path, total]
  else
    new_point = ''

    # get the next point in the path
    start.keys.first.split('-').each do |i|
      if i != point
        new_point = i
      end
    end

    # if node item doesn't exist in path construct...
    if !path.include?(new_point)
      # get all path nodes where the start (of this recursion) exists
      starts = $distances.map do |d|
        if (d.keys.first.include? new_point) && (!d.keys.first.include?(point))
          d
        end
      end.compact

      # build out paths
      res = starts.map do |s|
        ret = get_shortest_path(s, new_point, dest, total, path + '-' + new_point)
        #return path if complete criteria exists
        [ret[0], ret[1]] if ret && ret[0] && ret[1]
      end.compact

      final = nil

      res.each do |r|
        final = r if final == nil || r[1] < final[1]
      end

      final
    end
  end
end

def destination_exists?(start, dest)
  true if start.keys.first.include? dest
end

run('Vathlo', 'Xan')
run('Kryptonopolis', 'Kandor')
run('Bokos', 'Argo')
run('Vathlo', 'Kryptonopolis')
run('Kandor', 'Xan')
run('Vathlo', 'Argo')
run('Argo', 'Vathlo')
