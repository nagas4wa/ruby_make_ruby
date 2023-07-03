require 'minruby'
# fizzbuzzを組み込み関数にしてみる
require_relative 'fizzbuzz.rb'

def evaluate(tree, genv, lenv)
  case tree[0]
  when "lit"
    tree[1]
  when "+"
    # プロファイラ
    lenv["plus_count"] ||= 0
    lenv["plus_count"] += 1
    evaluate(tree[1], genv, lenv) + evaluate(tree[2], genv, lenv)
  when "-"
    evaluate(tree[1], genv, lenv) - evaluate(tree[2], genv, lenv)
  when "*"
    evaluate(tree[1], genv, lenv) * evaluate(tree[2], genv, lenv)
  when "/"
    evaluate(tree[1], genv, lenv) / evaluate(tree[2], genv, lenv)
  when "%"
    evaluate(tree[1], genv, lenv) % evaluate(tree[2], genv, lenv)
  when "**"
    evaluate(tree[1], genv, lenv) ** evaluate(tree[2], genv, lenv)
  when "func_call"
    args = []
    i = 0
    while tree[ i + 2]
      args[i] = evaluate(tree[i + 2], genv, lenv)
      i = i + 1
    end
    mhd = genv[tree[1]]
    if mhd[0] == "builtin"
      minruby_call(mhd[1], args)
    else
      # ユーザ定義関数(次の章)
    end
  when "stmts"
    # 複文の実装
    i = 1
    last = nil
    while tree[i] != nil
      last = evaluate(tree[i], genv, lenv)
      i = i + 1
    end
    last
  when "var_assign"
    # 変数定義する
    lenv[tree[1]] = evaluate(tree[2], genv, lenv)
  when "var_ref"
    # 変数参照
    lenv[tree[1]]
  when "if"
    if evaluate(tree[1], genv, lenv)
      evaluate(tree[2], genv, lenv)
    else
      evaluate(tree[3], genv, lenv)
    end
  when "=="
    evaluate(tree[1], genv, lenv) == evaluate(tree[2], genv, lenv)
  when "<"
    evaluate(tree[1], genv, lenv) < evaluate(tree[2], genv, lenv)
  when ">"
    evaluate(tree[1], genv, lenv) > evaluate(tree[2], genv, lenv)
  when "while"
    while evaluate(tree[1], genv, lenv)
      evaluate(tree[2], genv, lenv)
    end
  when "while2"
    loop do
      evaluate(tree[2], genv, lenv)
      break unless evaluate(tree[1], genv, lenv)
    end
  else
    pp tree
  end
end

str = minruby_load()

tree = minruby_parse(str)

genv = { "p" => ["builtin", "p"], "fizzbuzz" => ["builtin", "fizzbuzz"] }
lenv = {}
answer = evaluate(tree, genv, lenv)
