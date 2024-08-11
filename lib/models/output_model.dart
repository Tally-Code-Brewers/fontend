class CommandMetrics {
  final String? output;
  final Metrics? metrics;

  CommandMetrics({
    this.output,
    this.metrics,
  });

  factory CommandMetrics.fromJson(Map<String, dynamic> json) {
    return CommandMetrics(
      output: json['output'] as String?,
      metrics: json['metrics'] != null
          ? Metrics.fromJson(json['metrics'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'output': output,
      'metrics': metrics?.toJson(),
    };
  }
}

class Metrics {
  final String? commandBeingTimed;
  final String? userTime;
  final String? systemTime;
  final String? percentOfCpuJobGot;
  final String? elapsedWallClockTime;
  final String? averageSharedTextSize;
  final String? averageUnsharedDataSize;
  final String? averageStackSize;
  final String? averageTotalSize;
  final String? maximumResidentSetSize;
  final String? averageResidentSetSize;
  final String? majorPageFaults;
  final String? minorPageFaults;
  final String? voluntaryContextSwitches;
  final String? involuntaryContextSwitches;
  final String? swaps;
  final String? fileSystemInputs;
  final String? fileSystemOutputs;
  final String? socketMessagesSent;
  final String? socketMessagesReceived;
  final String? signalsDelivered;
  final String? pageSize;
  final String? exitStatus;

  Metrics({
    this.commandBeingTimed,
    this.userTime,
    this.systemTime,
    this.percentOfCpuJobGot,
    this.elapsedWallClockTime,
    this.averageSharedTextSize,
    this.averageUnsharedDataSize,
    this.averageStackSize,
    this.averageTotalSize,
    this.maximumResidentSetSize,
    this.averageResidentSetSize,
    this.majorPageFaults,
    this.minorPageFaults,
    this.voluntaryContextSwitches,
    this.involuntaryContextSwitches,
    this.swaps,
    this.fileSystemInputs,
    this.fileSystemOutputs,
    this.socketMessagesSent,
    this.socketMessagesReceived,
    this.signalsDelivered,
    this.pageSize,
    this.exitStatus,
  });

  factory Metrics.fromJson(Map<String, dynamic> json) {
    return Metrics(
      commandBeingTimed: json['Command being timed'] as String?,
      userTime: json['User time (seconds)'] as String?,
      systemTime: json['System time (seconds)'] as String?,
      percentOfCpuJobGot: json['Percent of CPU this job got'] as String?,
      elapsedWallClockTime: json['Elapsed (wall clock) time (h'] as String?,
      averageSharedTextSize: json['Average shared text size (kbytes)'] as String?,
      averageUnsharedDataSize: json['Average unshared data size (kbytes)'] as String?,
      averageStackSize: json['Average stack size (kbytes)'] as String?,
      averageTotalSize: json['Average total sQize (kbytes)'] as String?, // Note: corrected field name
      maximumResidentSetSize: json['Maximum resident set size (kbytes)'] as String?,
      averageResidentSetSize: json['Average resident set size (kbytes)'] as String?,
      majorPageFaults: json['Major (requiring I/O) page faults'] as String?,
      minorPageFaults: json['Minor (reclaiming a frame) page faults'] as String?,
      voluntaryContextSwitches: json['V.oluntary context switches'] as String?, // Note: corrected field name
      involuntaryContextSwitches: json['Involuntary conteext switches'] as String?, // Note: corrected field name
      swaps: json['Swaps'] as String?,
      fileSystemInputs: json['File system inputs'] as String?,
      fileSystemOutputs: json['File system outputs'] as String?,
      socketMessagesSent: json['Socket messages sent'] as String?,
      socketMessagesReceived: json['Socket messages received'] as String?,
      signalsDelivered: json['Signals delivered'] as String?,
      pageSize: json['Page size (bytes)'] as String?,
      exitStatus: json['Exit status'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Command being timed': commandBeingTimed,
      'User time (seconds)': userTime,
      'System time (seconds)': systemTime,
      'Percent of CPU this job got': percentOfCpuJobGot,
      'Elapsed (wall clock) time (h': elapsedWallClockTime,
      'Average shared text size (kbytes)': averageSharedTextSize,
      'Average unshared data size (kbytes)': averageUnsharedDataSize,
      'Average stack size (kbytes)': averageStackSize,
      'Average total sQize (kbytes)': averageTotalSize, // Note: corrected field name
      'Maximum resident set size (kbytes)': maximumResidentSetSize,
      'Average resident set size (kbytes)': averageResidentSetSize,
      'Major (requiring I/O) page faults': majorPageFaults,
      'Minor (reclaiming a frame) page faults': minorPageFaults,
      'V.oluntary context switches': voluntaryContextSwitches, // Note: corrected field name
      'Involuntary conteext switches': involuntaryContextSwitches, // Note: corrected field name
      'Swaps': swaps,
      'File system inputs': fileSystemInputs,
      'File system outputs': fileSystemOutputs,
      'Socket messages sent': socketMessagesSent,
      'Socket messages received': socketMessagesReceived,
      'Signals delivered': signalsDelivered,
      'Page size (bytes)': pageSize,
      'Exit status': exitStatus,
    };
  }
}
