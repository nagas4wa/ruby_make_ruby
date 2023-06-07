require "minruby"

def max(tree)
  if tree[0] == "lit"
    tree[1]
  else
    left = max(tree[1])
    right = max(tree[2])
    left < right ? right : left
  end
end

p(max(minruby_parse(gets)))