require 'minruby'

def evaluate(tree, env)
  case tree[0]
  when "lit"
    tree[1]
  when "+"
    # プロファイラ
    env["plus_count"] ||= 0
    env["plus_count"] += 1
    evaluate(tree[1], env) + evaluate(tree[2], env)
  when "-"
    evaluate(tree[1], env) - evaluate(tree[2], env)
  when "*"
    evaluate(tree[1], env) * evaluate(tree[2], env)
  when "/"
    evaluate(tree[1], env) / evaluate(tree[2], env)
  when "%"
    evaluate(tree[1], env) % evaluate(tree[2], env)
  when "**"
    evaluate(tree[1], env) ** evaluate(tree[2], env)
  when "func_call" # 仮実装
    p(evaluate(tree[2], env))
  when "stmts"
    # 複文の実装
    i = 1
    last = nil
    while tree[i] != nil
      last = evaluate(tree[i], env)
      i = i + 1
    end
    last
  when "var_assign"
    # 変数定義する
    env[tree[1]] = evaluate(tree[2], env)
  when "var_ref"
    # 変数参照
    env[tree[1]]
  when "if"
    if evaluate(tree[1], env)
      evaluate(tree[2], env)
    else
      evaluate(tree[3], env)
    end
  when "=="
    evaluate(tree[1], env) == evaluate(tree[2], env)
  when "<"
    evaluate(tree[1], env) < evaluate(tree[2], env)
  when ">"
    evaluate(tree[1], env) > evaluate(tree[2], env)
  when "while"
    while evaluate(tree[1], env)
      evaluate(tree[2], env)
    end
  when "while2"
    loop do
      evaluate(tree[2], env)
      break unless evaluate(tree[1], env)
    end
  else
    pp tree
  end
end

str = minruby_load()

tree = minruby_parse(str)

env = {}
answer = evaluate(tree, env)
