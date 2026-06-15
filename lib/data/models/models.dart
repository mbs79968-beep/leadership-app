import 'package:flutter/material.dart';

/// ───────────────────────── User & onboarding ─────────────────────────
enum LeadershipGoal { becomeLeader, confidence, communication, decisionMaking }

extension GoalLabel on LeadershipGoal {
  String get label => switch (this) {
        LeadershipGoal.becomeLeader => 'Become a leader',
        LeadershipGoal.confidence => 'Improve confidence',
        LeadershipGoal.communication => 'Improve communication',
        LeadershipGoal.decisionMaking => 'Better decision making',
      };
}

enum ExperienceLevel { rookie, emerging, established, executive }

extension ExpLabel on ExperienceLevel {
  String get label => switch (this) {
        ExperienceLevel.rookie => 'Rookie',
        ExperienceLevel.emerging => 'Emerging',
        ExperienceLevel.established => 'Established',
        ExperienceLevel.executive => 'Executive',
      };
}

class UserProfile {
  final String name;
  final int age;
  final LeadershipGoal goal;
  final String weakness;
  final ExperienceLevel experience;
  final int level;
  final int streak;
  final double levelProgress; // 0..1 toward next level

  const UserProfile({
    required this.name,
    required this.age,
    required this.goal,
    required this.weakness,
    required this.experience,
    this.level = 7,
    this.streak = 12,
    this.levelProgress = 0.62,
  });

  UserProfile copyWith({
    String? name,
    int? age,
    LeadershipGoal? goal,
    String? weakness,
    ExperienceLevel? experience,
  }) {
    return UserProfile(
      name: name ?? this.name,
      age: age ?? this.age,
      goal: goal ?? this.goal,
      weakness: weakness ?? this.weakness,
      experience: experience ?? this.experience,
      level: level,
      streak: streak,
      levelProgress: levelProgress,
    );
  }
}

/// ───────────────────────── Scenarios ─────────────────────────
enum ScenarioCategory {
  billionaireRoom,
  conflictZone,
  negotiationArena,
  publicSpeaking,
  crisisRoom,
}

extension CategoryMeta on ScenarioCategory {
  String get label => switch (this) {
        ScenarioCategory.billionaireRoom => 'Billionaire Room',
        ScenarioCategory.conflictZone => 'Conflict Zone',
        ScenarioCategory.negotiationArena => 'Negotiation Arena',
        ScenarioCategory.publicSpeaking => 'Public Speaking',
        ScenarioCategory.crisisRoom => 'Crisis Room',
      };

  IconData get icon => switch (this) {
        ScenarioCategory.billionaireRoom => Icons.diamond_outlined,
        ScenarioCategory.conflictZone => Icons.bolt_outlined,
        ScenarioCategory.negotiationArena => Icons.handshake_outlined,
        ScenarioCategory.publicSpeaking => Icons.campaign_outlined,
        ScenarioCategory.crisisRoom => Icons.warning_amber_rounded,
      };
}

enum Difficulty { foundational, advanced, elite }

extension DiffLabel on Difficulty {
  String get label => switch (this) {
        Difficulty.foundational => 'Foundational',
        Difficulty.advanced => 'Advanced',
        Difficulty.elite => 'Elite',
      };
}

class Scenario {
  final String id;
  final String title;
  final String subtitle;
  final ScenarioCategory category;
  final Difficulty difficulty;
  final int durationMin;
  final String mentorOpener; // what Atlas / the AI counterpart says first
  final int basePressure; // 0..100 starting pressure

  const Scenario({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.category,
    required this.difficulty,
    required this.durationMin,
    required this.mentorOpener,
    required this.basePressure,
  });
}

/// ───────────────────────── Missions ─────────────────────────
class Mission {
  final String title;
  final String description;
  final ScenarioCategory category;
  final int xp;
  final bool completed;

  const Mission({
    required this.title,
    required this.description,
    required this.category,
    required this.xp,
    this.completed = false,
  });
}

/// ───────────────────────── Skills & feedback ─────────────────────────
class Skill {
  final String name;
  final double value; // 0..100
  final double delta; // change since last week
  final IconData icon;

  const Skill({
    required this.name,
    required this.value,
    required this.delta,
    required this.icon,
  });
}

class FeedbackResult {
  final String scenarioTitle;
  final double confidence;
  final double persuasion;
  final double emotionalControl;
  final double clarity;
  final double leadershipImpact;
  final String mentorSummary;
  final List<String> mistakes;
  final List<String> improvements;

  const FeedbackResult({
    required this.scenarioTitle,
    required this.confidence,
    required this.persuasion,
    required this.emotionalControl,
    required this.clarity,
    required this.leadershipImpact,
    required this.mentorSummary,
    required this.mistakes,
    required this.improvements,
  });

  double get overall =>
      (confidence + persuasion + emotionalControl + clarity + leadershipImpact) /
      5;
}

/// ───────────────────────── Mentor (Atlas) ─────────────────────────
class MentorMessage {
  final String text;
  final bool fromAtlas;
  const MentorMessage({required this.text, this.fromAtlas = true});
}

/// Point on a weekly progression line chart.
class TrendPoint {
  final String label;
  final double value;
  const TrendPoint(this.label, this.value);
}
