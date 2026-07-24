/// @self							
/// @description					Function used for reading a signed 8 bit number from a file
/// @param {Id.BinaryFile} file		The ID of the file to get the data from
/// @returns {Real}
function file_bin_read_int8(file)
{
	var result = file_bin_read_byte(file);
	return result > 127 ? result - 256 : result;
}

/// @self							
/// @description					Function used for reading a unsigned 8 bit number from a file
/// @param {Id.BinaryFile} file		The ID of the file to get the data from
/// @returns {Real}
function file_bin_read_uint8(file)
{
	return file_bin_read_byte(file);
}

/// @self							
/// @description					Function used for writing a 16 bit integer to a file
/// @param {Id.BinaryFile} file		The ID of the file to write to
/// @param {Real} number			A number to write to a file
function file_bin_write_int16(file, number)
{
	for (var i = 0; i < 2; ++i) 
	{
		file_bin_write_byte(file, floor(number / power(0x100, 1 - i)) % 0x100);
	}
}

/// @self							
/// @description					Function used for reading a signed 16 bit number from a file
/// @param {Id.BinaryFile} file		The ID of the file to get the data from
/// @returns {Real}
function file_bin_read_int16(file)
{
	var result = file_bin_read_uint16(file);
	return result > 32767 ? result - 65535 : result;
}

/// @self							
/// @description					Function used for reading a unsigned 16 bit number from a file
/// @param {Id.BinaryFile} file		The ID of the file to get the data from
/// @returns {Real}
function file_bin_read_uint16(file)
{
	var result = 0;
	
	for (var i = 0; i < 2; ++i) 
	{
	    var byte = (file_bin_read_byte(file) & 0xFF) << 8 * (1 - i);
		result |= byte;
	}	
	
	return result;
}

/// @self							
/// @description					Function used for writing a 32 bit integer to a file
/// @param {Id.BinaryFile} file		The ID of the file to write to
/// @param {Real} number			A number to write to a fi
function file_bin_write_int32(file, number)
{
	for (var i = 0; i < 4; ++i) 
	{
		file_bin_write_byte(file, floor(number / power(0x100, 3 - i)) % 0x100);
	}
}

/// @self							
/// @description					Function used for reading a signed 32 bit number from a file
/// @param {Id.BinaryFile} file		The ID of the file to get the data from
/// @returns {Real}
function file_bin_read_int32(file)
{
	var result = file_bin_read_uint32(file);
	return result > 2147483647 ? result - 4294967295 : result;
}

/// @self							
/// @description					Function used for reading a unsigned 32 bit number from a file
/// @param {Id.BinaryFile} file		The ID of the file to get the data from
/// @returns {Real}
function file_bin_read_uint32(file)
{
	var result = 0;
	
	for (var i = 0; i < 4; ++i) 
	{
	    var byte = (file_bin_read_byte(file) & 0xFF) << 8 * (3 - i);
		result |= byte;
	}	
	
	return result;
}