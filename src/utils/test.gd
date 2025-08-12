class_name Test
extends Object

## To test something, add a test function and call it with Test.run in the
## beggining of _ready function in a node you're testing. In that funciton, you
## should use Test.are_eq for your assertions. Errors will appear in the
## console when your node is initialized.

const TESTS_ARE_FATAL := false


static func _handle_error(msg: String, expected: Variant, actual: Variant) -> void:
	if TESTS_ARE_FATAL:
		assert(false, "%s, expected %s, got %s" % [msg, expected, actual])
	else:
		push_error("%s, expected %s, got %s" % [msg, expected, actual])


static func is_(value: bool, msg := "must work as expected") -> void:
	if value:
		return

	_handle_error(msg, true, value)


static func is_not(value: bool, msg := "must work as expected") -> void:
	if not value:
		return

	_handle_error(msg, false, value)


static func are_eq(actual: Variant, expected: Variant, msg := "must work as expected") -> void:
	if actual == expected:
		return

	_handle_error(msg, expected, actual)


static func run(fn: Callable) -> void:
	if OS.has_feature("standalone"):
		return

	print("running a test %s" % fn.get_method())
	fn.call()
