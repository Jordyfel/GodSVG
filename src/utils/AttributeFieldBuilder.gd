class_name AttributeFieldBuilder

static var TransformFieldScene: PackedScene = preload("res://src/ui_widgets/transform_field.tscn")
static var NumberFieldScene: PackedScene = preload("res://src/ui_widgets/number_field.tscn")
static var NumberSliderScene: PackedScene = preload("res://src/ui_widgets/number_field_with_slider.tscn")
static var ColorFieldScene: PackedScene = preload("res://src/ui_widgets/color_field.tscn")
static var EnumFieldScene: PackedScene = preload("res://src/ui_widgets/enum_field.tscn")
static var IdFieldScene: PackedScene = preload("res://src/ui_widgets/id_field.tscn")
static var UnrecognizedFieldScene: PackedScene = preload("res://src/ui_widgets/unrecognized_field.tscn")

static func create(attribute: String, element: Element) -> Control:
	match DB.get_attribute_type(attribute):
		DB.AttributeType.ID: return _generate_no_name(IdFieldScene, element)
		DB.AttributeType.TRANSFORM_LIST: return _generate(TransformFieldScene, element, attribute)
		DB.AttributeType.COLOR: return _generate(ColorFieldScene, element, attribute)
		DB.AttributeType.ENUM: return _generate(EnumFieldScene, element, attribute)
		DB.AttributeType.NUMERIC:
			match DB.attribute_number_range[attribute]:
				DB.NumberRange.UNIT: return _generate(NumberSliderScene, element, attribute)
				_: return _generate(NumberFieldScene, element, attribute)
		_: return _generate(UnrecognizedFieldScene, element, attribute)

static func _generate(widget: PackedScene, element: Element, attribute: String) -> Control:
	var widget_instance := widget.instantiate()
	widget_instance.element = element
	widget_instance.attribute_name = attribute
	return widget_instance

static func _generate_no_name(widget: PackedScene, element: Element) -> Control:
	var widget_instance := widget.instantiate()
	widget_instance.element = element
	return widget_instance
