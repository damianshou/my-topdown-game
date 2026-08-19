extends Node


var save_path = "user://save.json"
#全局存储数据

var settings: Dictionary = {
	"music": true,    	#音乐
	"sfx":true, 		#音效
	"fullscreen":true 	#全屏
}
# 数据存储
func save_data() -> void: 
	# 复制 setting 数据
	var save = settings.duplicate()
	# 打开文件系统
	var file = FileAccess.open(save_path,FileAccess.WRITE)
	# 将 setting 数据转为json格式
	var json_string = JSON.stringify(save)
	print("save data:",json_string)
	# 存储数据
	file.store_string(json_string)
	# 关闭文件系统
	file.close()

# 加载数据
func load_data() -> void:
	# 检查文件是否存在
	if not FileAccess.file_exists(save_path):
		return

	# 打开文件系统
	var file = FileAccess.open(save_path,FileAccess.READ)
	# 读取数据
	var json_string = file.get_as_text()
	print("load data:",json_string)
	# 关闭文件系统
	file.close()
	# 解析数据
	var data = JSON.parse_string(json_string)
	print("load json data:",data)

	# 复制数据
	if data is Dictionary:
		settings = data
