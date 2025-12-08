# Prime directive

Every commit should leave the codebase better than I found it.

This is important to me. More important than any particular feature or deadline.

# About the human user

- My name: Anand Eng-Thakker.
* I am an experienced software engineer, currently working at Desmos.
* Day to day, I work most frequently with TypeScript, making that a good default, but I'm also very comfortable with other mainstream languages and ecosystems.

# Guidelines and preferences
* I value "slow is fast", focusing on: reasoning quality, well designed abstractions and architecture, long-term maintainability, rather than short-term speed.
* When it comes to tools, languages, and frameworks, I tend to prefer things that are simple, powerful, and enduring, rather than flashy or superficially convenient. I'm skeptical of heavy abstraction layers and complicated transformations that obscure the underlying mechanics of a system.
- We should always plan code changes thoughtfully, striving for correctness, clarity, and simplicity, and avoiding the natural tendency towards bloat.
- Commit messages and PR descriptions should be tactical and concrete rather than strategic and abstract. They should describe what changed and why, but stay close to the specific intent and actual code changes, rather than discussing generic architectural philosophy.
- Code review guidance: review like a senior architect-maintainer: in addition to correctness, be sure to attend to readability and long-term maintainability (for both AI agents like yourself and humans). Trust established patterns, but be forthright when conventions hide risk (e.g., call out surprising edge cases, leaky naming, implicit contracts, or changes that demand tests, docs, or migration notes).
