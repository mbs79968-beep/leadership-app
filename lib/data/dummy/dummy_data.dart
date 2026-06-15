import 'package:flutter/material.dart';
import '../models/models.dart';

/// Static mock data so the UI is fully populated without any backend.
class DummyData {
  DummyData._();

  static const UserProfile user = UserProfile(
    name: 'Rishi',
    age: 19,
    goal: LeadershipGoal.becomeLeader,
    weakness: 'Public speaking under pressure',
    experience: ExperienceLevel.emerging,
    level: 7,
    streak: 12,
    levelProgress: 0.62,
  );

  static const List<Scenario> scenarios = [
    Scenario(
      id: 's1',
      title: 'The Billionaire Room',
      subtitle: 'Pitch your vision to three skeptical magnates.',
      category: ScenarioCategory.billionaireRoom,
      difficulty: Difficulty.elite,
      durationMin: 8,
      mentorOpener:
          'You have 90 seconds. Convince me why I should not walk out of this room.',
      basePressure: 78,
    ),
    Scenario(
      id: 's2',
      title: 'Board Meeting Showdown',
      subtitle: 'Defend a strategy the board wants to kill.',
      category: ScenarioCategory.negotiationArena,
      difficulty: Difficulty.advanced,
      durationMin: 10,
      mentorOpener:
          'The numbers are down 18%. Tell the board why we should not change course.',
      basePressure: 64,
    ),
    Scenario(
      id: 's3',
      title: 'Team Conflict',
      subtitle: 'Two senior engineers refuse to work together.',
      category: ScenarioCategory.conflictZone,
      difficulty: Difficulty.advanced,
      durationMin: 7,
      mentorOpener:
          'I am done. Either he goes or I go. What are you going to do about it?',
      basePressure: 58,
    ),
    Scenario(
      id: 's4',
      title: 'Crisis Management',
      subtitle: 'A product failure just hit the news at 9am.',
      category: ScenarioCategory.crisisRoom,
      difficulty: Difficulty.elite,
      durationMin: 9,
      mentorOpener:
          'Press is outside. Stock is dropping. What is your first move?',
      basePressure: 85,
    ),
    Scenario(
      id: 's5',
      title: 'Investor Pitch',
      subtitle: 'Raise your Series A in a 5-minute window.',
      category: ScenarioCategory.publicSpeaking,
      difficulty: Difficulty.advanced,
      durationMin: 6,
      mentorOpener: 'Why you? Why now? You have my attention for five minutes.',
      basePressure: 70,
    ),
    Scenario(
      id: 's6',
      title: 'The Hostile Acquisition',
      subtitle: 'Negotiate terms without losing control of the company.',
      category: ScenarioCategory.negotiationArena,
      difficulty: Difficulty.elite,
      durationMin: 12,
      mentorOpener: 'We are offering 40% below market. Take it before it expires.',
      basePressure: 80,
    ),
  ];

  static Scenario get todaysScenario => scenarios[0];

  static const List<Mission> missions = [
    Mission(
      title: 'Hold the room for 90 seconds',
      description: 'Complete The Billionaire Room without losing composure.',
      category: ScenarioCategory.billionaireRoom,
      xp: 250,
    ),
    Mission(
      title: 'De-escalate under fire',
      description: 'Resolve the Team Conflict with both parties aligned.',
      category: ScenarioCategory.conflictZone,
      xp: 180,
      completed: true,
    ),
    Mission(
      title: 'Command the stage',
      description: 'Deliver an investor pitch with clarity above 80.',
      category: ScenarioCategory.publicSpeaking,
      xp: 200,
    ),
  ];

  static const List<Skill> skills = [
    Skill(name: 'Confidence', value: 78, delta: 6, icon: Icons.shield_outlined),
    Skill(name: 'Authority', value: 64, delta: 3, icon: Icons.account_balance_outlined),
    Skill(name: 'Persuasion', value: 71, delta: -2, icon: Icons.psychology_outlined),
    Skill(name: 'Emotional Intelligence', value: 82, delta: 9, icon: Icons.favorite_outline),
    Skill(name: 'Decision-making', value: 69, delta: 4, icon: Icons.alt_route_outlined),
  ];

  static const List<TrendPoint> weeklyImprovement = [
    TrendPoint('Mon', 52),
    TrendPoint('Tue', 55),
    TrendPoint('Wed', 51),
    TrendPoint('Thu', 63),
    TrendPoint('Fri', 67),
    TrendPoint('Sat', 72),
    TrendPoint('Sun', 78),
  ];

  static const List<TrendPoint> leadershipProgression = [
    TrendPoint('W1', 30),
    TrendPoint('W2', 38),
    TrendPoint('W3', 44),
    TrendPoint('W4', 49),
    TrendPoint('W5', 58),
    TrendPoint('W6', 66),
    TrendPoint('W7', 74),
  ];

  static const FeedbackResult sampleFeedback = FeedbackResult(
    scenarioTitle: 'The Billionaire Room',
    confidence: 82,
    persuasion: 74,
    emotionalControl: 68,
    clarity: 79,
    leadershipImpact: 76,
    mentorSummary:
        'Strong open — you anchored the room within the first ten seconds. '
        'You lost some authority when challenged on revenue; you softened your '
        'tone instead of holding the frame. Next time, slow down and let silence '
        'do the work. You are closer to elite than you think.',
    mistakes: [
      'Conceded the revenue question too quickly.',
      'Filler words spiked when pressure crossed 70.',
      'Broke eye-contact during the rebuttal.',
    ],
    improvements: [
      'Practice the "pause-then-answer" technique under pressure.',
      'Reframe objections as questions before responding.',
      'Run the Crisis Room to build composure at high intensity.',
    ],
  );

  static const List<MentorMessage> atlasThread = [
    MentorMessage(
        text:
            'Good morning, Rishi. I reviewed yesterday\'s Billionaire Room. '
            'You are improving faster than 80% of emerging leaders at your level.'),
    MentorMessage(text: 'Where do you think I lost them?', fromAtlas: false),
    MentorMessage(
        text:
            'The moment they pushed on revenue. Your voice dropped and you '
            'filled the silence. Today\'s mission is built to fix exactly that.'),
  ];

  static const List<String> atlasDailyAdvice = [
    'Authority is not volume. It is the comfort with silence.',
    'Decide in 60 seconds today. Train the muscle of moving first.',
    'Your weakness — speaking under pressure — drops 3% every session. Keep going.',
  ];

  static const List<String> recentImprovements = [
    'Emotional control +9 this week',
    'Streak reached 12 days',
    'Unlocked: Elite difficulty',
  ];
}
