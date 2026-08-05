# Questio — Context for AI Assistants

> What the startup is, what users do, and what we're building. Bullets only.

---

## What Questio Is

- iOS app that turns any PDF into a Duolingo-style interactive learning game
- User uploads a PDF → AI builds a knowledge graph → generates a playable lesson
- Tagline direction: *"Turn any PDF into a game that teaches it"* / *"Duolingo for whatever you're actually studying"*
- Two founders: Othman (iOS + product) · Malek (backend + AI)
- Pre-launch, pre-revenue · target TestFlight: 2026-08-20 · applying to YC Winter 2027

---

## Core Idea / Insight

- The material you need to learn already exists as a PDF — turning it into practice should take one upload, not a week of making flashcards
- Generic AI quiz tools chunk-and-prompt; Questio builds a **knowledge graph** that knows what depends on what, enabling dependency ordering and relational questions — not just fact recall
- Competitors like Duolingo have the retention mechanics but only teach what they decided to build; Anki requires you to author every card yourself

---

## User Journeys

### First-Time User
- Installs from TestFlight
- Onboarding → auth (email or guest)
- Lands on empty home screen
- Picks a PDF from Files app or share sheet
- Watches upload progress → processing states (queued → processing → ready)
- Course appears → taps Play
- Plays Duolingo-style game: question → answer → immediate feedback → next
- Finishes session → sees result screen (score, progress)
- Optional: plays second game mode (flash cards)

### Returning User
- Opens app → home / library shows all uploaded courses
- Picks a course → course detail (preview, manage)
- Plays another session → progress persists across launches

### Sharing Flow (F2 — our only growth loop)
- User finishes or opens a course → taps Share
- Gets a link/code to send anywhere
- Recipient opens it → plays the same course
- Recipients without the app land on the App Store (universal link)

### Quality Report Flow (F3)
- On any course or question, user taps Report
- Picks a category (questions don't match doc / too easy / answers wrong / garbled / other)
- Free-text description submitted with context (document ID, graph ID, model version, app version)
- User gets confirmation a human will see it

### Upload Failure States
- Validation fail (file too big, wrong type) → instant rejection with reason
- Processing fail (retriable) → "what went wrong" + Retry action
- Processing fail (terminal, e.g. scanned PDF with no text layer) → clear explanation + Report option

---

## MVP Features (shipping 2026-08-20)

### F1 — Upload a PDF, play the game
- Pick PDF from Files or share sheet
- Client-side validation before upload
- Upload with visible progress %
- State machine: queued → processing → ready → failed
- Backend builds knowledge graph, generates lesson
- **Duolingo-style mode**: MCQ, true/false, matching — question → immediate feedback → next
- Progress persists across launches
- Second game mode (flash cards) — in scope only if F1 done by Aug 10

### F2 — Share a course
- Share a generated course via link/code
- Recipient can play it without having uploaded anything
- Mechanism undecided: universal link (preferred for growth) vs invite code vs public URL

### F3 — Report processing quality
- Free-text report on any course or question
- Attached context: document ID, graph ID, question ID, model version
- Our primary signal for pipeline failures on documents we never picked

---

## Screens (11 total)

- Onboarding
- Auth (email sign-up/sign-in, or guest)
- Home / library (your courses)
- Course detail (preview, rename, delete)
- Upload (pick, upload, processing states)
- Game — Duolingo mode (core loop)
- Session result (score, progress, what next)
- Game — Flash cards (second mode)
- Share sheet
- Report
- Settings (account, privacy, sign out)

### Critical Path
```
first launch → onboarding → auth → home (empty)
  → upload → [processing] → course detail → game (Duolingo) → result
                                   ↓                              ↓
                            game (flash cards)                 share (F2)
```

---

## How the Backend Works (Technical)

- PDF uploaded → text extracted (rejects scanned/image-only PDFs)
- Text normalized (CRLF, RTL, Unicode NFC, de-hyphenation) → chunked with overlap
- LLM proposes concepts from labelled chunks
- **Knowledge graph extracted**: nodes = entities, edges = `head → relation → tail` per concept's chunks
- Concept links: `prerequisite_of` | `related`
- Per concept: LLM generates intro card (definitional or relational) + ladder of items
- LLM critic validates and removes bad items
- Optional matching items generated if quality cleared
- Instructor/pipeline validates → published as a stage snapshot
- Learner serving (M6–M7) not yet built — highest-priority backend work

### Item Types
- `mcq` — multiple choice (2–4 choices, easy/medium only)
- `true_false` — exactly `["True", "False"]`
- `matching` — 4–6 pairs (can be hard)

### Tech Stack
- iOS: SwiftUI, Swift 6, Core Data, async/await
- Backend: Go · Gin · Postgres · River job queue · 3 LLM providers (Anthropic, OpenAI, dev CLI)
- Analytics: PostHog

---

## Post-MVP Ideas (Parking Lot)

- Streaks, XP, leaderboards (Duolingo retention mechanics — needs retained users first)
- Push notifications (needs streaks worth notifying about)
- Offline play (users will ask; not before)
- iPad support (after iPhone retention is proven)
- Android (post-YC decision)
- In-app purchase / paywall (after knowing what people pay for)
- Multiple PDFs per course
- Editing generated questions in-app (vs. reporting them)
- Session replay (for specific debugging questions)
- Web version (long-term direction)

---

## Key Metrics

- **North Star**: Weekly Active Learners (unique users completing ≥1 game in a rolling 7 days)
- **Activation hypothesis**: uploaded ≥1 PDF AND completed ≥1 game within 24h of first open
- **Pipeline health**: `graph_generation_succeeded / graph_generation_started` (target ≥90%)
- **Growth rate**: week-over-week on Weekly Active Learners (target 5–7%/week)
- **Time-to-value**: p50/p90 from upload started → first course viewable

---

## What Substitutes People Use Today

- Rereading the PDF and highlighting
- Making flashcards by hand (Anki)
- Pasting chunks into ChatGPT and asking it to quiz them
- Doing nothing — intending to study and not following through

---

## Biggest Risks

- Generation quality on PDFs we didn't pick (scanned handouts, 400-page textbooks, non-English)
- Time-to-value too long if processing takes >2 min (changes the entire upload UX)
- One-and-done usage if the core loop isn't compelling enough to return to
- Nobody having a PDF they're motivated to study (strongest for students/exam-preppers)
