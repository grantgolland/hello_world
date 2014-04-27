require 'github_api'

current_valuation = 0
current_karma = 0

SCHEDULER.every '2s' do
  last_valuation = current_valuation
  last_karma     = current_karma
  current_valuation = rand(100)
  current_karma     = rand(200000)
  the_time = Time.now

  send_event('welcome', { title: "bonjour", text: "sucer ma bite", moreinfo: "It's #{the_time}."  })
  send_event('valuation', { current: current_valuation, last: last_valuation })
  send_event('karma', { current: current_karma, last: last_karma })
  send_event('synergy',   { value: rand(100) })
end

SCHEDULER.every '60s', :first_in => 0 do
   github = Github.new
   commit_message = github.repos.commits.all(ENV['GITHUBUSERNAME'], ENV['GITHUBREPONAME']).first.commit.message
   send_event('recent_git_commit', { text: commit_message })   
end
