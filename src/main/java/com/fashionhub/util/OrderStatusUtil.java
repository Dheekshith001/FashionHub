package com.fashionhub.util;

import java.time.LocalDate;
import java.time.temporal.ChronoUnit;

/**
 * Computes customer-facing order phase from calendar days since order date (day 1 = order date).
 */
public final class OrderStatusUtil {

    private OrderStatusUtil() {
    }

    public static String computePhase(LocalDate orderDate, LocalDate today) {
        if (orderDate == null || today == null) {
            return "Order Confirmed";
        }
        long dayIndex = ChronoUnit.DAYS.between(orderDate, today) + 1;
        if (dayIndex < 1) {
            dayIndex = 1;
        }
        if (dayIndex == 1) {
            return "Order Confirmed";
        }
        if (dayIndex == 2) {
            return "Packed";
        }
        if (dayIndex == 3) {
            return "Shipped";
        }
        if (dayIndex >= 4 && dayIndex <= 6) {
            return "Out For Delivery";
        }
        return "Delivered";
    }
}
