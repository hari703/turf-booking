class Booking {
  final String userId;
  final String slotId;
  final String selectedSport;
  final DateTime selectedDate;
  final String selectedTimeSlot;
  final bool isFullCourt;
  final double subTotal;
  final double discount;
  final double payableAmount;
  final double advancePayment;

  Booking({
    required this.userId,
    required this.slotId,
    required this.selectedSport,
    required this.selectedDate,
    required this.selectedTimeSlot,
    required this.isFullCourt,
    required this.subTotal,
    required this.discount,
    required this.payableAmount,
    required this.advancePayment,
  });

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'slotId': slotId,
      'selectedSport': selectedSport,
      'selectedDate': selectedDate.toIso8601String(),
      'selectedTimeSlot': selectedTimeSlot,
      'isFullCourt': isFullCourt,
      'subTotal': subTotal,
      'discount': discount,
      'payableAmount': payableAmount,
      'advancePayment': advancePayment,
    };
  }
}
