/// @self								
/// @description						Function that eases the value using the "InSine" formula
/// @param {Real} val					A precent value (ranges between 0.0 - 1.0)
/// @return {Real}
function ease_in_sine(val)
{
	return 1 - cos((val * pi) / 2);
}

/// @self								
/// @description						Function that eases the value using the "OutSine" formula
/// @param {Real} val					A precent value (ranges between 0.0 - 1.0)
/// @return {Real}
function ease_out_sine(val)
{
	return sin((val * pi) / 2);
}

/// @self								
/// @description						Function that eases the value using the "InOutSine" formula
/// @param {Real} val					A precent value (ranges between 0.0 - 1.0)
/// @return {Real}
function ease_in_out_sine(val)
{
	return -(cos(pi * val) - 1) / 2;
}

/// @self								
/// @description						Function that eases the value using the "InQuad" formula
/// @param {Real} val					A precent value (ranges between 0.0 - 1.0)
/// @return {Real}
function ease_in_quad(val) 
{
	return val * val;
}

/// @self								
/// @description						Function that eases the value using the "OutQuad" formula
/// @param {Real} val					A precent value (ranges between 0.0 - 1.0)
/// @return {Real}
function ease_out_quad(val)
{
	return 1 - (1 - val) * (1 - val);
}

/// @self								
/// @description						Function that eases the value using the "InOutQuad" formula
/// @param {Real} val					A precent value (ranges between 0.0 - 1.0)
/// @return {Real}
function ease_in_out_quad(val)
{
	return val < 0.5 ? 2 * val * val : 1 - power(-2 * val + 2, 2) / 2;
}

/// @self								
/// @description						Function that eases the value using the "InCubic" formula
/// @param {Real} val					A precent value (ranges between 0.0 - 1.0)
/// @return {Real}
function ease_in_cubic(val)
{
	return val * val * val;
}

/// @self								
/// @description						Function that eases the value using the "OutCubic" formula
/// @param {Real} val					A precent value (ranges between 0.0 - 1.0)
/// @return {Real}
function ease_out_cubic(val)
{
	return 1 - power(1 - val, 3);
}

/// @self								
/// @description						Function that eases the value using the "InOutCubic" formula
/// @param {Real} val					A precent value (ranges between 0.0 - 1.0)
/// @return {Real}
function ease_in_out_cubic(val) 
{
	return val < 0.5 ? 4 * val * val * val : 1 - power(-2 * val + 2, 3) / 2;
}

/// @self								
/// @description						Function that eases the value using the "InQuart" formula
/// @param {Real} val					A precent value (ranges between 0.0 - 1.0)
/// @return {Real}
function ease_in_quart(val)
{
	return val * val * val * val;
}

/// @self								
/// @description						Function that eases the value using the "OutQuart" formula
/// @param {Real} val					A precent value (ranges between 0.0 - 1.0)
/// @return {Real}
function ease_out_quart(val) 
{
	return 1 - power(1 - val, 4);
}

/// @self								
/// @description						Function that eases the value using the "InOutQuart" formula
/// @param {Real} val					A precent value (ranges between 0.0 - 1.0)
/// @return {Real}
function ease_in_out_quart(val) 
{
	return val < 0.5 ? 8 * val * val * val * val : 1 - power(-2 * val + 2, 4) / 2;
}

/// @self								
/// @description						Function that eases the value using the "InQuint" formula
/// @param {Real} val					A precent value (ranges between 0.0 - 1.0)
/// @return {Real}
function ease_in_quint(val)
{
	return val * val * val * val * val;
}

/// @self								
/// @description						Function that eases the value using the "OutQuint" formula
/// @param {Real} val					A precent value (ranges between 0.0 - 1.0)
/// @return {Real}
function ease_out_quint(val) 
{
	return 1 - power(1 - val, 5);
}

/// @self								
/// @description						Function that eases the value using the "InOutQuint" formula
/// @param {Real} val					A precent value (ranges between 0.0 - 1.0)
/// @return {Real}
function ease_in_out_quint(val)
{
	return val < 0.5 ? 16 * val * val * val * val * val : 1 - power(-2 * val + 2, 5) / 2;
}

/// @self								
/// @description						Function that eases the value using the "InExpo" formula
/// @param {Real} val					A precent value (ranges between 0.0 - 1.0)
/// @return {Real}
function ease_in_expo(val) 
{
	return val == 0 ? 0 : power(2, 10 * val - 10);
}

/// @self								
/// @description						Function that eases the value using the "OutExpo" formula
/// @param {Real} val					A precent value (ranges between 0.0 - 1.0)
/// @return {Real}
function ease_out_expo(val) 
{
	return val == 1 ? 1 : 1 - power(2, -10 * val);
}

/// @self								
/// @description						Function that eases the value using the "InOutExpo" formula
/// @param {Real} val					A precent value (ranges between 0.0 - 1.0)
/// @return {Real}
function ease_in_out_expo(val) 
{
	return ((val == 0) ? 0 : ((val == 1) ? 1 : ((val < 0.5) ? (power(2, 20 * val - 10) / 2) : ((2 - power(2, -20 * val + 10)) / 2))));
}

/// @self								
/// @description						Function that eases the value using the "InCirc" formula
/// @param {Real} val					A precent value (ranges between 0.0 - 1.0)
/// @return {Real}
function ease_in_circ(val)
{
	return 1 - sqrt(1 - power(val, 2));
}

/// @self								
/// @description						Function that eases the value using the "OutCirc" formula
/// @param {Real} val					A precent value (ranges between 0.0 - 1.0)
/// @return {Real}
function ease_out_circ(val)
{
	return sqrt(1 - power(val - 1, 2));
}

/// @self								
/// @description						Function that eases the value using the "InOutCirc" formula
/// @param {Real} val					A precent value (ranges between 0.0 - 1.0)
/// @return {Real}
function ease_in_out_circ(val)
{
	return val < 0.5 ? (1 - sqrt(1 - power(2 * val, 2))) / 2 : (sqrt(1 - power(-2 * val + 2, 2)) + 1) / 2;
}

/// @self								
/// @description						Function that eases the value using the "InBack" formula
/// @param {Real} val					A precent value (ranges between 0.0 - 1.0)
/// @return {Real}
function ease_in_back(val)
{
	var c1 = 1.70158;
	var c3 = c1 + 1;
	return c3 * val * val * val - c1 * val * val;
}

/// @self								
/// @description						Function that eases the value using the "OutBack" formula
/// @param {Real} val					A precent value (ranges between 0.0 - 1.0)
/// @return {Real}
function ease_out_back(val) 
{
	var c1 = 1.70158;
	var c3 = c1 + 1;
	return 1 + c3 * power(val - 1, 3) + c1 * power(val - 1, 2);
}

/// @self								
/// @description						Function that eases the value using the "InOutBack" formula
/// @param {Real} val					A precent value (ranges between 0.0 - 1.0)
/// @return {Real}
function ease_in_out_back(val)
{
	var c1 = 1.70158;
	var c2 = c1 * 1.525;
	return val < 0.5 ? (power(2 * val, 2) * ((c2 + 1) * 2 * val - c2)) / 2 : (power(2 * val - 2, 2) * ((c2 + 1) * (val * 2 - 2) + c2) + 2) / 2;
}

/// @self								
/// @description						Function that eases the value using the "InElastic" formula
/// @param {Real} val					A precent value (ranges between 0.0 - 1.0)
/// @return {Real}
function ease_in_elastic(val)
{
	var c4 = (2 * pi) / 3;
	return ((val == 0) ? 0 : ((val == 1) ? 1 : (-power(2, 10 * val - 10) * sin((val * 10 - 10.75) * c4))));
}

/// @self								
/// @description						Function that eases the value using the "OutElastic" formula
/// @param {Real} val					A precent value (ranges between 0.0 - 1.0)
/// @return {Real}
function ease_out_elastic(val) 
{
	var c4 = (2 * pi) / 3;
	return power(2, -10 * val) * sin((val * 10 - 0.75) * c4) + 1;
}

/// @self								
/// @description						Function that eases the value using the "InOutElastic" formula
/// @param {Real} val					A precent value (ranges between 0.0 - 1.0)
/// @return {Real}
function ease_in_out_elastic(val)
{
	var c5 = (2 * pi) / 4.5;
	return ((val == 0) ? 0 : ((val == 1) ? 1 : ((val < 0.5) ? (-(power(2, 20 * val - 10) * sin((20 * val - 11.125) * c5)) / 2) : ((power(2, -20 * val + 10) * sin((20 * val - 11.125) * c5)) / 2 + 1))));
}

/// @self								
/// @description						Function that eases the value using the "InBounce" formula
/// @param {Real} val					A precent value (ranges between 0.0 - 1.0)
/// @return {Real}
function ease_in_bounce(val)
{
	return 1 - ease_out_bounce(1 - val);
}

/// @self								
/// @description						Function that eases the value using the "OutBounce" formula
/// @param {Real} val					A precent value (ranges between 0.0 - 1.0)
/// @return {Real}
function ease_out_bounce(val)
{
    var n1 = 7.5625;
    var d1 = 2.75;

    if (val < 1 / d1)
    {
        return n1 * val * val;
    }
    else if (val < 2 / d1)
    {
        val = val - 1.5 / d1;
        return n1 * val * val + 0.75;
    }
    else if (val < 2.5 / d1)
    {
        val = val - 2.25 / d1;
        return n1 * val * val + 0.9375;
    }
    else
    {
        val = val - 2.625 / d1;
        return n1 * val * val + 0.984375;
    }
}

/// @self								
/// @description						Function that eases the value using the "InOutBounce" formula
/// @param {Real} val					A precent value (ranges between 0.0 - 1.0)
/// @return {Real}
function ease_in_out_bounce(val) 
{
	return val < 0.5 ? (1 - ease_out_bounce(1 - 2 * val)) / 2 : (1 + ease_out_bounce(2 * val - 1)) / 2;
}