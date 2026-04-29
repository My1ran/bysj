import unittest

from range_utils import RangeNotSatisfiable, content_range_header, parse_range_header


class RangeUtilsTest(unittest.TestCase):
    def test_parse_closed_range(self):
        self.assertEqual(parse_range_header("bytes=10-19", 100), (10, 19))

    def test_parse_open_ended_range(self):
        self.assertEqual(parse_range_header("bytes=90-", 100), (90, 99))

    def test_parse_suffix_range(self):
        self.assertEqual(parse_range_header("bytes=-10", 100), (90, 99))

    def test_clamps_end_to_file_size(self):
        self.assertEqual(parse_range_header("bytes=95-200", 100), (95, 99))

    def test_ignores_non_byte_range_units(self):
        self.assertIsNone(parse_range_header("items=0-10", 100))

    def test_invalid_range_raises(self):
        with self.assertRaises(RangeNotSatisfiable):
            parse_range_header("bytes=100-120", 100)

    def test_content_range_header(self):
        self.assertEqual(content_range_header(10, 19, 100), "bytes 10-19/100")


if __name__ == "__main__":
    unittest.main()
