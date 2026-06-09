# Life Manager — Final Master Reference V7
## Claude Code Final Edition

> Status: FINAL AUTHORITATIVE REFERENCE
> Version: 7.0
> Purpose: Single Source of Truth for Life Manager

---

# MVP Scope

## Included in MVP
- Tasks
- Goals
- Habits
- Timer
- Finance
- Dashboard
- KPI System
- Daily Score
- Focus Score
- Life Balance Score
- Weekly Review
- Monthly Reflection

## Excluded From MVP (Future)
- Personal Knowledge System
- Personal CRM
- Decision Journal

These systems must not be implemented during MVP development.

---

# Non-Negotiable Constraints

- Flutter is mandatory.
- Dart is mandatory.
- Riverpod is mandatory.
- SQLite is mandatory.
- Drift is mandatory.
- Offline-first operation is mandatory.
- User owns all data.
- No advertising.
- No tracking.
- No third-party analytics.
- No cloud dependency in MVP.
- No authentication in MVP.

---

# Build Order

## Phase 1
Tasks, Goals, Habits, Timer, Finance

## Phase 2
Dashboard, KPI System, Scores, Reviews

## Phase 3
AI Coach, Forecasting, Insights

## Future
Knowledge System, CRM, Decision Journal

---

# Definition of Done

A feature is complete only when:
- UI implemented
- State management implemented
- Repository implemented
- Local database implemented
- Works offline
- Error states handled
- Empty states handled
- Navigation integrated
- Consistent with design system
- Tests pass

---

# 1. Product Identity

## Product Name
Life Manager

## Product Category
Personal Operating System

## Product Mission
Help the user make better decisions and improve life through structured capture, organization, measurement and reflection.

## Product Vision
A unified system that manages:
- Goals
- Tasks
- Time
- Habits
- Money
- Knowledge
- Personal Growth

inside a single environment.

# 2. Core Philosophy

## Capture First
Record now. Organize later.

## Local First
Everything works offline.

## Simplicity First
Complexity is rejected unless it creates meaningful value.

## Data Ownership
User owns all data.
No advertising.
No external tracking.

## Decision Support
The objective is not recording life.
The objective is improving life.

# 3. Product Evolution
1. Capture
2. Organization
3. Measurement
4. Optimization
5. Decision Support
6. Personal Operating System

# 4. Life Areas Framework

Every major object must belong to at least one Life Area.

Life Areas:
- Career
- Business
- Finance
- Health
- Learning
- Relationships
- Family
- Personal Growth
- Recreation
- Spirituality

Purpose:
- Prevent invisible neglect
- Create life balance visibility

# 5. Information Architecture

HOME
TASKS
GOALS
FINANCE
MORE

MORE:
- TIMER
- HABITS
- DASHBOARD
- SETTINGS

# 6. Global Navigation Rules

Bottom Navigation:
- Home
- Tasks
- Goals
- Finance
- More

Global FAB:
- Add Task
- Add Expense
- Start Timer
- Add Goal
- Add Habit

# 7. User Journey

## Morning
- Review priorities
- Review habits
- Start timer

## Day
- Capture tasks
- Capture expenses
- Track time
- Complete habits

## Evening
- Review day
- Review progress
- Plan tomorrow

## Weekly
- Review goals
- Process inbox
- Review metrics

## Monthly
- Reflection
- Goal review
- Financial review
- Life balance review

# 8. Home Module
Purpose: Command Center

Contains:
- Quick Actions
- Today's Tasks
- Active Timer
- Habit Summary
- Finance Snapshot
- Daily Score
- Top Priorities
- Goal Focus

# 9. Daily Focus System
- Top 3 Priorities
- Critical Goal
- Critical Habit

Rule: No more than 3 priorities.

# 10. Tasks Module

Purpose: Action Management

Task Types:
- Goal Linked
- Standalone

Statuses:
- Inbox
- Planned
- In Progress
- Completed
- Cancelled

Priorities:
- Low
- Medium
- High
- Critical

Views:
- Today
- Upcoming
- Inbox
- Completed
- All

Task Creation Time Target: Under 5 seconds

# 11. Inbox System

Inbox exists for:
- Tasks
- Finance
- Future Notes

Inbox Review Frequency: Twice Weekly

Success KPI: Inbox Zero Rate

# 12. Goals Module

Hierarchy:
Long Goal → Short Goal → Tasks

Goal States:
- Active
- Paused
- Completed
- Cancelled

Goal Health States:
- On Track
- At Risk
- Off Track
- Completed

# 13. Goal Review Engine

Monthly Review evaluates:
- Progress
- Deadline
- Completion Velocity

Flags risk automatically.

# 14. Timer Module

Purpose: Measure Reality

Categories:
- Deep Work
- Shallow Work
- Learning
- Exercise
- Personal
- Family
- Recovery
- Miscellaneous

Timer States:
- Idle
- Running
- Paused
- Completed

# 15. Deep Work System

Metrics:
- Deep Work Hours
- Deep Work Ratio
- Weekly Trend
- Monthly Trend

Purpose: Measure meaningful effort.

# 16. Finance Module

Purpose: Financial Awareness

Sections:
- Transactions
- Debts
- Financial Goals

Transaction Types:
- Expense
- Income

Financial Dashboard:
- Income
- Expense
- Balance
- Savings Rate
- Category Distribution

# 17. Habits Module

Purpose: Behavior Formation

Habit Metrics:
- Current Streak
- Best Streak
- Success Rate
- Consistency Score

Daily Habit Instances Generated Automatically.

# 18. Dashboard Module

Purpose: Convert Data Into Decisions

Sections:
- Productivity
- Goals
- Time
- Finance
- Habits
- Life Balance

All KPI cards expandable.

# 19. KPI System

User-defined metrics.

Examples:
- Savings
- Weight
- Books Read
- Revenue
- Exercise Hours
- Deep Work Hours

# 20. Daily Score
- Task Completion 30%
- Habit Completion 30%
- Goal Progress 20%
- Time Tracking 20%

Range: 0–100

# 21. Focus Score
- Task Completion 25%
- Habit Completion 20%
- Goal Progress 20%
- Deep Work 20%
- Planning Consistency 15%

Range: 0–100

# 22. Life Balance Score

Measures balance across Life Areas using:
- Time
- Goals
- Habits
- KPIs

Purpose: Detect neglected areas.

# 23. Weekly Review System

Includes:
- Completed Tasks
- Goal Progress
- Habit Performance
- Time Allocation
- Finance Summary
- Insights

Reflection Questions:
- What worked?
- What failed?
- What was learned?

# 24. Monthly Reflection System

Questions:
- What should continue?
- What should stop?
- What should start?
- What am I proud of?

Stored permanently.

# 25. AI Coach Layer

Rule: AI advises. AI never controls.

Capabilities:
- Goal Risk Detection
- Habit Analysis
- Time Analysis
- Spending Analysis
- Pattern Recognition
- Weekly Summaries
- Monthly Summaries
- Forecasting

# 26. Forecasting Engine

Predict:
- Goal Completion Date
- Financial Goal Completion
- Habit Success Probability

# 27. Personal Knowledge System (Future)

Store:
- Ideas
- Lessons
- Insights
- Quotes
- Notes

Linked to:
- Goals
- Tasks
- Projects
- Life Areas

# 28. Personal CRM (Future)

Track:
- People
- Relationships
- Follow-ups
- Important Dates

# 29. Decision Journal (Future)

Record:
- Decision
- Reasoning
- Expected Outcome
- Actual Outcome

Purpose: Improve decision quality.

# 30. Design Direction

Style:
- Minimal
- Modern
- Data-Oriented
- Premium

Inspirations:
- Notion
- Linear
- Todoist
- Apple Human Interface Design

# 31. Design System

Radius: 4, 8, 12, 16, 24
Spacing: 4, 8, 12, 16, 24, 32, 48, 64
Typography: Inter

Colors:
- Primary: #2563EB
- Success: #22C55E
- Warning: #F59E0B
- Danger: #EF4444

# 32. Technical Stack

- Flutter
- Dart
- Riverpod
- Drift
- SQLite
- Go Router
- fl_chart
- flutter_local_notifications
- flutter_secure_storage

# 33. Architecture Principles

- Local First
- Modular First
- Feature Driven
- Repository Pattern
- Provider Architecture

# 34. Project Structure

```text
core/
shared/
features/
  home/
  tasks/
  goals/
  finance/
  habits/
  timer/
  dashboard/
  settings/
```

# 35. Database Architecture

Tables:
- tasks
- goals_long
- goals_short
- transactions
- debts
- financial_goals
- time_logs
- habits
- habit_logs
- settings
- kpis
- reviews

# 36. Database Relationships

- Long Goal (1:N) Short Goals
- Short Goal (1:N) Tasks
- Task (1:N) Time Logs
- Habit (1:N) Habit Logs
- Financial Goal (1:N) Transactions

# 37. Business Rules

- Deleting Goal does not delete Tasks
- Deleting Habit does not delete History
- Timer Overlap Forbidden
- Completed Tasks archived after 30 days

# 38. Notifications

- Morning Summary 08:00
- Habit Reminder Configurable
- Overdue Tasks 19:00
- Weekly Review Reminder Sunday Evening

# 39. Backup Strategy

1. Local Only
2. Encrypted Export
3. Google Drive Backup
4. Cloud Sync

# 40. Security Principles

- No Ads
- No Tracking
- No Data Selling
- No Third-Party Analytics
- User Owns Data

# 41. Performance Targets

- Cold Start < 2 sec
- Screen Navigation < 300 ms
- Database Query < 100 ms
- Task Creation < 5 sec
- Expense Creation < 5 sec

# 42. Success Definition

The application succeeds when the user can answer:
- What matters most today?
- Am I progressing toward my goals?
- Where is my time going?
- Where is my money going?
- Which habits are helping or hurting me?
- Which area of life is being neglected?

# 43. Final Product Vision

Life Manager is not:
- A task manager
- A habit tracker
- A finance app
- A timer

Life Manager is a Personal Operating System that transforms:

Data → Awareness → Insight → Better Decisions → Better Life

---

# FINAL PROJECT RULE

Any feature, screen, workflow, architecture decision, AI capability, database modification or roadmap item must satisfy:

1. Improves clarity
2. Improves speed
3. Preserves offline-first operation
4. Preserves user ownership of data
5. Improves decision quality

If it fails any of these rules, it should not be built.


# Personal Roadmap (Wave System)

## Wave 1 — Daily Control System ✅ DONE
- Tasks (Inbox, Today, All)
- Goals (Long + Short)
- Home (Command Center)

## Wave 2 — Reality Tracking System
- Timer
- Finance
- Habits

## Wave 3 — Personal Analytics
- Dashboard
- KPI System
- Daily Score / Focus Score / Life Balance Score

## Wave 4 — Reflection System
- Weekly Review
- Monthly Review
- Goal Review

## Wave 5 — Personal Intelligence
- AI Coach
- Forecasting

## Wave 6 — Personal Operating System (Future, after 6 months real usage)
- Knowledge System
- Decision Journal
- Personal CRM

---

# Claude Code Session Rules

1. هر session فقط یک task مشخص انجام بده
2. قبل از هر تغییر، وضعیت فعلی رو بررسی کن
3. بعد از هر تغییر، flutter analyze اجرا کن
4. هیچ Wave جدیدی شروع نکن مگه اینکه صریحاً خواسته بشه
5. همیشه طبق سند V7 پیش برو
6. برای تمام عملیات‌های زیر نیازی به تأیید نیست و مستقیم انجام بده:
   - خواندن و نوشتن فایل‌های پروژه
   - اجرای flutter pub get
   - اجرای dart run build_runner build
   - اجرای flutter analyze
   - اجرای git add و git commit
