# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# will delete cascade
User.destroy_all

u1 = User.create(email: 'demo@users.com', password: 'qweqwe')
u2 = User.create(email: 'none@nothing.com', password: 'qweqwe')

p1 = Project.create({ title: 'my pivotal tracker clone', owner: u1, capacity: 6 })
p1.tabs.create([
  { name: 'current', ord: 0 },
  { name: 'backlog', ord: 1 },
  { name: 'icebox', ord: 2 },
  { name: 'done', ord: 3 }
])

p1.tabs.find_by(name: 'done').stories.create([
  { title: 'write UML diagram', kind: 'chore', points: 1, state: 'accepted',
    ord: 0, deadline: '2014-07-15'},
  { title: 'write use case diagram', kind: 'chore', points: 2,
    state: 'accepted', ord: 1, deadline: '2014-07-16'}
])

p1.tabs.find_by(name: 'current').stories.create([
  { title: 'project model', kind: 'feature', points: 1, state: 'started',
    ord: 0, deadline: '2014-08-04', maximized: true,
    description: 'rails API project model, implement validations and associations'},
  { title: 'tab model', kind: 'feature', points: 1, state: 'started', ord: 1,
    deadline: '2014-08-05'},
  { title: 'story model', kind: 'feature', points: 2, state: 'started', ord: 2}
])

p1.tabs.find_by(name: 'backlog').stories.create([
  { title: 'project view', kind: 'feature', points: 1, state: 'unstarted', ord: 0},
  { title: 'fix drag&drop', kind: 'bug', points: 3, state: 'unstarted', ord: 1,
    maximized: true,
    description: 'drag&drop stops working after tab sort'},
  { title: 'fix sortables', kind: 'bug', points: 4, state: 'unstarted', ord: 3},
  { title: 'tab view', kind: 'feature', points: 2, state: 'unstarted', ord: 4},
  { title: 'story view', kind: 'feature', points: 3, state: 'unstarted', ord: 5}
])

p1.tabs.find_by(name: 'icebox').stories.create([
  { title: 'register heroku website', kind: 'chore', state: 'unstarted', ord: 0},
  { title: 'DRY up the code', kind: 'chore', state: 'unstarted', ord: 1},
  { title: 'release 0.1b', kind: 'release', points: 3, state: 'unstarted',
    ord: 2, deadline: '2014-08-10', maximized: true,
    description: 'first beta presentation to management'},
])

p2 = Project.create({ title: 'new ideas about trello', owner: u1, capacity: 4 })
p2.tabs.create([
  { name: 'current', ord: 0 },
  { name: 'backlog', ord: 1 },
  { name: 'icebox', ord: 2 },
  { name: 'done', ord: 3 }
])

p2.tabs.find_by(name: 'backlog').stories.create([
  { title: 'assign user to card', kind: 'feature', points: 1, state: 'unstarted', ord: 0},
  { title: 'fix css shadow when hovering', kind: 'bug', points: 2, state: 'unstarted', ord: 1,
    maximized: true, description: 'the shadow looks bad', deadline: '2014-08-06'},
  { title: 'assign collaborator to board', kind: 'feature', points: 2,
    state: 'unstarted', ord: 3, description: 'we need a collaboration model',
    deadline: '2014-08-04'},
  { title: 'tilt card when dragging', kind: 'feature', points: 1, state: 'unstarted', ord: 4},
  { title: 'find a good background', kind: 'chore', points: 1, state: 'unstarted', ord: 5}
])

p2.tabs.find_by(name: 'icebox').stories.create([
  { title: 'register heroku website', kind: 'chore', state: 'unstarted', ord: 0},
  { title: 'purchase SSL', kind: 'chore', state: 'unstarted', ord: 1,
    description: 'make the website secure'},
  { title: 'release 0.1b', kind: 'release', points: 3, state: 'unstarted',
    ord: 2, deadline: '2014-08-10', maximized: true,
    description: 'presentation to potential employers'},
])

p2.tabs.find_by(name: 'done').stories.create([
  { title: 'finish the board backbone model', kind: 'feature', points: 1,
    state: 'accepted', ord: 0, deadline: '2014-07-15'},
  { title: 'brainstorming about new ideas', kind: 'chore', points: 2,
    state: 'accepted', ord: 1, deadline: '2014-07-16'}
])