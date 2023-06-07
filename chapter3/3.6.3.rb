require_relative 'node'

def postorder(tree)
  if tree[0].start_with?("節")
    postorder tree[1]
    postorder tree[2]
  end
  p tree[0]
end

postorder node