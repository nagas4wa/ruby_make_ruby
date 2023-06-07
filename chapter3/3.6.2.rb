require_relative 'node.rb'

def preoder(tree)
  p tree[0] if tree[0].start_with?("葉")
  if tree[0].start_with?("節")
    preoder tree[1]
    preoder tree[2]
  end
end

preoder node