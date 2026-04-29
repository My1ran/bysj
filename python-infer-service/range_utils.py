class RangeNotSatisfiable(ValueError):
    pass


def parse_range_header(range_header: str, file_size: int):
    if not range_header or not range_header.lower().startswith("bytes="):
        return None
    if file_size <= 0:
        raise RangeNotSatisfiable("empty file")

    value = range_header.split("=", 1)[1].strip()
    if "," in value:
        raise RangeNotSatisfiable("multiple ranges are not supported")

    start_text, separator, end_text = value.partition("-")
    if separator != "-":
        raise RangeNotSatisfiable("invalid range")

    if start_text == "":
        suffix_length = _parse_int(end_text)
        if suffix_length <= 0:
            raise RangeNotSatisfiable("invalid suffix range")
        start = max(file_size - suffix_length, 0)
        end = file_size - 1
    else:
        start = _parse_int(start_text)
        if start >= file_size:
            raise RangeNotSatisfiable("range starts after file end")
        end = file_size - 1 if end_text == "" else min(_parse_int(end_text), file_size - 1)

    if start < 0 or end < start:
        raise RangeNotSatisfiable("invalid range bounds")
    return start, end


def content_range_header(start: int, end: int, file_size: int) -> str:
    return f"bytes {start}-{end}/{file_size}"


def _parse_int(value: str) -> int:
    try:
        return int(value)
    except (TypeError, ValueError):
        raise RangeNotSatisfiable("range value is not an integer")
