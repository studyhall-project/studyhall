alias StudyHall.CourseCatalog.Course

# Make some sample courses to play with.

titles = [
  "Coding and Coffee: Brewing Beautiful Websites",
  "JavaScript Jedi Training: May the Functions Be with You",
  "The CSS Circus: Where Styles Meet Smiles",
  "HTML: Hilariously Tagging Markup Language",
  "Node.js Nonsense: Making Servers Silly",
  "React Revolution: Building Web Apps with a Twist",
  "The Git Gurus: Committing to Comedy",
  "Web Wonders with Wix: Creating Sites and Laughs",
  "API Adventures: A Quest for Web Development Fun",
  "Coding Campfire: Roasting Bugs and Marshmallows",
  "Web Dev Wizardry: From 'Hello World' to Hilarity",
  "The Ruby Rodeo: Riding Rails to Ridiculousness",
  "PHP Puns and Practices: Server-Side Giggles",
  "Python's Web Party: Flask & Django Disco",
  "HTML Heroes: Unleash Your Markup Superpowers",
  "Web Dev Riddles: Solving Problems with a Chuckle",
  "Angular Antics: Fun with Front-End Frameworks",
  "The Vue from Here: A Comedy of Errors",
  "Joking with Java: Scripting for Fun and Funnies",
  "Web Development Stand-Up: Laugh, Learn, Code",
  "Docker Doodle: Container Comedy Club",
  "Kubernetes Capers: Orchestrating Laughter",
  "DevOps Comedy Central: From Chaos to Chuckles",
  "Web Animation Extravaganza: CSS & Giggles",
  "Code Bloopers and Blunders: Web Dev Edition",
  "Web Scraping Hilarity: A Crawling Comedy Show",
  "Web Performance Comedy Hour: Faster Sites, More Chuckles",
  "Testing Tomfoolery: Quality Assurance Comedy",
  "Web Dev Comedy Therapy: Healing with Humor"
]

for title <- titles do
  %Course{} = Course.create!(%{title: title})
end
