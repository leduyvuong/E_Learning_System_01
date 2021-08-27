module TestsHelper
  def change_ans(questions)
    ans = questions.answers.to_a
    if ans.count > 3
      a = [0, 1, 2, 3]
      ran_1 = a.sample
      a.delete(ran_1)
      ran_2 = a.sample
      a.delete(ran_2)
      ans[ran_1], ans[ran_2] = ans[ran_2], ans[ran_1]
      ans[a[0]], ans[a[1]] = ans[a[1]], ans[a[0]]
    end
    ans
  end
end
