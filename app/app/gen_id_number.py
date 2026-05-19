#!/usr/bin/python
# -*- coding:utf8 -*-

class TAJValidator:
    TAJ_LENGTH = 9
    TAJ_WEIGHTS = [3, 7, 1, 3, 7, 1, 3, 7]

    @classmethod
    def validate_hungary_taj(cls, taj: str) -> dict:
        # Basic checks: length and all digits
        if len(taj) != cls.TAJ_LENGTH or not taj.isdigit():
            return {'valid': False, 'corrected_taj': None}

        total_sum = 0
        id_digits_count = cls.TAJ_LENGTH - 1  # 8

        # Tính tổng có trọng số của 8 chữ số đầu tiên
        for i in range(id_digits_count):
            total_sum += int(taj[i]) * cls.TAJ_WEIGHTS[i]

        # Chữ số kiểm tra là chữ số cuối cùng của tổng (chia lấy dư cho 10)
        calculated_check_digit = total_sum % 10
        provided_check_digit = int(taj[id_digits_count])  # index 8

        if calculated_check_digit != provided_check_digit:
            # Strings are immutable: build new string with corrected check digit (at index 8)
            corrected_taj = taj[:8] + str(calculated_check_digit)
            return {'valid': False, 'corrected_taj': corrected_taj}

        return {'valid': True, 'corrected_taj': None}

# ==========================================
# CÁCH SỬ DỤNG
# ==========================================
if __name__ == "__main__":
    # Test với một chuỗi bất kỳ
    result = TAJValidator.validate_hungary_taj("088376674")
    print(result)  # e.g. {'valid': False, 'corrected_taj': '088376678'}