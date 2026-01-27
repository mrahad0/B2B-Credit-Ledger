import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../controller/retailer_controller/retailer_controller.dart';
import '../../../data/model/retailer_model.dart';

class RetailerDetailsScreen extends StatefulWidget {
  final int retailerId;

  const RetailerDetailsScreen({super.key, required this.retailerId});

  @override
  State<RetailerDetailsScreen> createState() => _RetailerDetailsScreenState();
}

class _RetailerDetailsScreenState extends State<RetailerDetailsScreen> {
  late RetailerController retailerController;
  RxInt selectedFilter = 0.obs; // 0 = All, 1 = Credit, 2 = Debit

  @override
  void initState() {
    super.initState();
    retailerController = Get.find<RetailerController>();
  }

  List<LedgerEntry> get filteredEntries {
    final retailer = retailerController.selectedRetailer.value;
    if (retailer == null || retailer.ledgerEntries == null) return [];
    
    switch (selectedFilter.value) {
      case 1:
        return retailer.ledgerEntries!.where((e) => e.isCredit).toList();
      case 2:
        return retailer.ledgerEntries!.where((e) => e.isDebit).toList();
      default:
        return retailer.ledgerEntries!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: Obx(() {
          final isLoading = retailerController.isLoadingDetails.value;
          final retailer = retailerController.selectedRetailer.value;

          return SingleChildScrollView(
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
                            "back".tr,
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
                            color: const Color(0xFF22C55E).withValues(alpha: 0.3),
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
                if (isLoading)
                  _buildProfileSkeleton()
                else if (retailer != null)
                  _buildProfileCard(retailer),

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
                      "history".tr,
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
                            "newEntry".tr.toUpperCase(),
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
                if (!isLoading && retailer != null)
                  Obx(() => Row(
                    children: [
                      GestureDetector(
                        onTap: () => selectedFilter.value = 0,
                        child: _buildFilterChip(
                          "${"all".tr.toUpperCase()} • ${retailer.totalEntries}",
                          isSelected: selectedFilter.value == 0,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      GestureDetector(
                        onTap: () => selectedFilter.value = 1,
                        child: _buildFilterChip(
                          "${"credit".tr.toUpperCase()} • ${retailer.creditEntries}",
                          isSelected: selectedFilter.value == 1,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      GestureDetector(
                        onTap: () => selectedFilter.value = 2,
                        child: _buildFilterChip(
                          "${"debit".tr.toUpperCase()} • ${retailer.debitEntries}",
                          isSelected: selectedFilter.value == 2,
                        ),
                      ),
                    ],
                  )),

                SizedBox(height: 24.h),

                // 5. Transaction List
                if (isLoading)
                  Column(
                    children: List.generate(
                      2,
                      (index) => Padding(
                        padding: EdgeInsets.only(bottom: 16.h),
                        child: _buildTransactionSkeleton(),
                      ),
                    ),
                  )
                else if (retailer != null)
                  Obx(() {
                    final entries = filteredEntries;
                    if (entries.isEmpty) {
                      return Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 40.h),
                          child: Column(
                            children: [
                              Icon(
                                Icons.receipt_long_outlined,
                                size: 48.sp,
                                color: const Color(0xFF94A3B8),
                              ),
                              SizedBox(height: 12.h),
                              Text(
                                "noTransactions".tr,
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF64748B),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                    return Column(
                      children: entries
                          .map(
                            (entry) => Padding(
                              padding: EdgeInsets.only(bottom: 16.h),
                              child: _buildTransactionCard(entry: entry),
                            ),
                          )
                          .toList(),
                    );
                  }),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildProfileSkeleton() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
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
              color: const Color(0xFFF1F5F9),
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(height: 16.h),
          Container(
            height: 20.h,
            width: 150.w,
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(4.r),
            ),
          ),
          SizedBox(height: 8.h),
          Container(
            height: 14.h,
            width: 120.w,
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(4.r),
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
                Container(
                  height: 12.h,
                  width: 100.w,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1F5F9),
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                ),
                SizedBox(height: 8.h),
                Container(
                  height: 32.h,
                  width: 120.w,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1F5F9),
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileCard(RetailerData retailer) {
    Color balanceColor;
    if (retailer.isDue) {
      balanceColor = const Color(0xFFEF4444);
    } else if (retailer.isPaid) {
      balanceColor = const Color(0xFF10B981);
    } else {
      balanceColor = const Color(0xFF64748B);
    }

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
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
                  color: const Color(0xFF2563EB).withValues(alpha: 0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Center(
              child: Text(
                retailer.initial,
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
            retailer.fullName ?? "Unknown",
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF0F172A),
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            retailer.shopName ?? "",
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
                  "currentBalance".tr.toUpperCase(),
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF94A3B8),
                    letterSpacing: 1,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  "৳${retailer.formattedBalance}",
                  style: TextStyle(
                    fontSize: 32.sp,
                    fontWeight: FontWeight.bold,
                    color: balanceColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionSkeleton() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 44.w,
            height: 44.w,
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5F9),
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 12.h,
                  width: 60.w,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1F5F9),
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                ),
                SizedBox(height: 6.h),
                Container(
                  height: 14.h,
                  width: 120.w,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1F5F9),
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 16.h,
            width: 60.w,
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(4.r),
            ),
          ),
        ],
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
                  color: const Color(0xFF0F172A).withValues(alpha: 0.2),
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

  Widget _buildTransactionCard({required LedgerEntry entry}) {
    final isDeposit = entry.isCredit;
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
            color: Colors.black.withValues(alpha: 0.02),
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
                  entry.formattedDate,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF94A3B8),
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  entry.description ?? entry.note ?? (isDeposit ? "Credit" : "Debit"),
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
                "৳${entry.formattedAmount}",
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

