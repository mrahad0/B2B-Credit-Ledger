import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_extension/util/app_colors.dart';

class RetailerDetailsScreen extends StatelessWidget {
  const RetailerDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. Header Navigation
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: Row(
                        children: [
                          Icon(
                            Icons.arrow_back,
                            size: 24.sp,
                            color: const Color(0xFF0F172A),
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            "Back",
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF0F172A),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: EdgeInsets.all(10.w),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFEF2F2),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.person_outline_rounded,
                        color: const Color(0xFFEF4444),
                        size: 20.sp,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Container(
                      padding: EdgeInsets.all(10.w),
                      decoration: BoxDecoration(
                        color: const Color(0xFF22C55E),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF22C55E).withOpacity(0.3),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.chat_bubble_outline_rounded,
                        color: Colors.white,
                        size: 20.sp,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 24.h),

                // 2. Profile Summary Card
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(24.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(32.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.03),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: 80.w,
                        height: 80.w,
                        decoration: BoxDecoration(
                          color: const Color(0xFF2563EB),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF2563EB).withOpacity(0.3),
                              blurRadius: 20,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            "K",
                            style: TextStyle(
                              fontSize: 32.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        "Kabir Ahmed",
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF0F172A),
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        "Mayer Doa Enterprise",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF64748B),
                        ),
                      ),
                      SizedBox(height: 24.h),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 20.h),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF8FAFC),
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "CURRENT BALANCE",
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF94A3B8),
                                letterSpacing: 1,
                              ),
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              "৳45,000",
                              style: TextStyle(
                                fontSize: 32.sp,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFFEF4444),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 32.h),

                // 3. History Header
                Row(
                  children: [
                    Icon(
                      Icons.filter_alt_outlined,
                      color: const Color(0xFF64748B),
                      size: 20.sp,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      "History",
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF0F172A),
                      ),
                    ),
                    const Spacer(),
                    Container(
                      width: 40.w,
                      height: 40.w,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                      ),
                      child: Icon(
                        Icons.swap_vert_rounded,
                        color: const Color(0xFF64748B),
                        size: 20.sp,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 10.h,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEFF6FF),
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.add_circle_outline_rounded,
                            color: const Color(0xFF2563EB),
                            size: 16.sp,
                          ),
                          SizedBox(width: 6.w),
                          Text(
                            "NEW ENTRY",
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF2563EB),
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 20.h),

                // 4. Filters
                Row(
                  children: [
                    _buildFilterChip("ALL • 2", isSelected: true),
                    SizedBox(width: 12.w),
                    _buildFilterChip("CREDIT • 1", isSelected: false),
                    SizedBox(width: 12.w),
                    _buildFilterChip("DEBIT • 1", isSelected: false),
                  ],
                ),

                SizedBox(height: 24.h),

                // 5. Transaction List
                _buildTransactionCard(
                  type: TransactionType.deposit,
                  date: "21 JAN",
                  title: "Initial Deposit",
                  amount: "5,000",
                ),
                SizedBox(height: 16.h),
                _buildTransactionCard(
                  type: TransactionType.debit,
                  date: "21 JAN",
                  title: "Batch #12 Cement",
                  amount: "50,000",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label, {required bool isSelected}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF0F172A) : Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        border: isSelected ? null : Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: isSelected
            ? [
                BoxShadow(
                  color: const Color(0xFF0F172A).withOpacity(0.2),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ]
            : null,
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.bold,
          color: isSelected ? Colors.white : const Color(0xFF94A3B8),
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildTransactionCard({
    required TransactionType type,
    required String date,
    required String title,
    required String amount,
  }) {
    final isDeposit = type == TransactionType.deposit;
    final color = isDeposit ? const Color(0xFF10B981) : const Color(0xFFEF4444);
    final bgColor = isDeposit
        ? const Color(0xFFECFDF5)
        : const Color(0xFFFEF2F2);
    final icon = isDeposit
        ? Icons.arrow_upward_rounded
        : Icons.arrow_downward_rounded;

    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(color: bgColor, shape: BoxShape.circle),
            child: Icon(icon, color: color, size: 20.sp),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  date,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF94A3B8),
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF0F172A),
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "৳$amount",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          SizedBox(width: 16.w),
          Icon(
            Icons.delete_outline_rounded,
            color: const Color(0xFFCBD5E1),
            size: 20.sp,
          ),
        ],
      ),
    );
  }
}

enum TransactionType { deposit, debit }
