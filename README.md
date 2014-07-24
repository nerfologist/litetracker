# LiteTracker
## a Pivotal Tracker clone
A lightweight helping tool for Agile software developing.

Current herokuapp website: http://litetracker.herokuapp.com/

## Current status:
**under construction**

## Next steps:
1. Working Rails API
  - user model & controller, auth ✓
  - session controller ✓
  - project model & controller ✓
  - tab model & controller ✓
  - story model & controller ✓
  - sane API, well defined routes ✓
2. Backbone
  - project model & view structure (paper template first)
  - projects collection. Top-level projects collection.
  - tab model & view structure (paper template first)
  - tabs collection (project has one tabs collection)
  - story model & view structure (paper template first)
  - stories collection. Top-level stories collection. Tab level stories collection.
3. JavaScript
  - routes
  - views implementation
  - views event handling (listening to models and collections)
  - views event handling (listening to user interface elements)
  - drag & drop stories between tabs
4. Polish
  - CSS and styling (bootstrap)
  - add a logo
  - add a captivating homepage
  - add demo user & seed content
  - DRYing out code
  - fixing quirks
5. Extra
  - implement collaboration

## Class diagram
![](https://raw.githubusercontent.com/nerfologist/docs/master/images/class_diagram.png)

## Use case diagram
![](https://raw.githubusercontent.com/nerfologist/docs/master/images/use_case_diagram.png)

## Glossary

- Backlog (tab): container for stories, prioritised
- Current (tab): container for stories that are to be addressed in the current time unit (week? day?)
- Done (tab): container for completed stories
- Icebox (tab): new stories are created here
- Point: unit of complexity, used for evaluating stories
- Project: activity that we want to track. Can be divided in stories
- Story: synthetic description of a use case. Its complexity can be evaluated in points. Also: a concrete or deliverable task
- Tab: container for stories
- Velocity: points that can be completed at every time unit.

## Planned features
- account creation/auth
- user can create projects
- projects come with four tabs (story containers): current, backlog, icebox, done
- user can create stories. Stories are created in the icebox tab
- Current tab must contain the current stories at all times
- user can evaluate the complexity of stories from "1: trivial" to "4: very complex"
- user can start, finish deliver, accept or reject stories
- user can set stories' priority (only for stories that have not been started yet)
- user can set a velocity. A default velocity must be assumed


### Optional features
- variable time unit length (week, day, month)
- user can invite other users to collaborate on his project (collaboration)
- user has an event timeline