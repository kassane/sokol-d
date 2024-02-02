//------------------------------------------------------------------------------
//  math.d
//
//  minimal vector math helper functions, just the stuff needed for
//  the sokol-samples
//
//  Ported from HandmadeMath.h
//------------------------------------------------------------------------------

module handmade.math;

extern (C):
@safe:

version (WebAssembly)
{
    // zig stdlib no-libc math functions
    enum PI = 3.14159265358979323846264338327950288419716939937510;
    double zig_sqrt(size_t value) @nogc nothrow @trusted;
    double zig_sqrtf(double value) @nogc nothrow @trusted;
    double zig_cos(double value) @nogc nothrow @trusted;
    double zig_sin(double value) @nogc nothrow @trusted;
    double zig_tan(double value) @nogc nothrow @trusted;
    alias cos = zig_cos;
    alias sin = zig_sin;
    alias tan = zig_tan;

    auto sqrt(T)(T value)
    {
        static if (is(T == double) || is(T == float))
        {
            return zig_sqrtf(value);
        }
        else
        {
            return zig_sqrt(value);
        }
    }
}
else
{
    public import core.stdc.math : sqrt, cos, sin, tan;
    public import std.math : PI;
}

struct Vec2
{
    float x = 0.0, y = 0.0;

    static Vec2 zero()
    {
        return Vec2(0, 0);
    }

    this(float x, float y)
    {
        this.x = x;
        this.y = y;
    }
}

struct Vec3
{
    float x = 0.0, y = 0.0, z = 0.0;

    static Vec3 zero()
    {
        return Vec3(0, 0, 0);
    }

    this(float x, float y, float z)
    {
        this.x = x;
        this.y = y;
        this.z = z;
    }

    static Vec3 up()
    {
        return Vec3(0, 1, 0);
    }

    float len() const
    {
        return sqrt(dot(this, this));
    }

    static Vec3 add(Vec3 left, Vec3 right)
    {
        return Vec3(left.x + right.x, left.y + right.y, left.z + right.z);
    }

    static Vec3 sub(Vec3 left, Vec3 right)
    {
        return Vec3(left.x - right.x, left.y - right.y, left.z - right.z);
    }

    static Vec3 mul(Vec3 v, float s)
    {
        return Vec3(v.x * s, v.y * s, v.z * s);
    }

    static Vec3 norm(Vec3 v)
    {
        auto l = v.len;
        if (l != 0)
        {
            return Vec3(v.x / l, v.y / l, v.z / l);
        }
        else
        {
            return Vec3.zero;
        }
    }

    static Vec3 cross(Vec3 v0, Vec3 v1)
    {
        return Vec3((v0.y * v1.z) - (v0.z * v1.y), (v0.z * v1.x) - (v0.x * v1.z),
            (v0.x * v1.y) - (v0.y * v1.x));
    }

    static float dot(Vec3 v0, Vec3 v1)
    {
        return v0.x * v1.x + v0.y * v1.y + v0.z * v1.z;
    }
}

struct Mat4
{
    float[4][4] m;

    static Mat4 identity()
    {
        return Mat4([[1, 0, 0, 0], [0, 1, 0, 0], [0, 0, 1, 0], [0, 0, 0, 1]]);
    }

    static Mat4 zero()
    {
        return Mat4([[0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0]]);
    }

    static Mat4 mul(Mat4 left, Mat4 right)
    {
        Mat4 result = Mat4.zero;

        foreach (row; 0 .. 4)
        {
            foreach (col; 0 .. 4)
            {
                result.m[row][col] = left.m[row][0] * right.m[0][col]
                    + left.m[row][1] * right.m[1][col] + left.m[row][2]
                    * right.m[2][col] + left.m[row][3] * right.m[3][col];
            }
        }

        return result;
    }

    static Mat4 perspective(float fov, float aspect, float near, float far)
    {
        Mat4 result = Mat4.identity;

        float t = tan(fov * (PI / 360.0));
        result.m[0][0] = 1.0 / t;
        result.m[1][1] = aspect / t;
        result.m[2][3] = -1.0;
        result.m[2][2] = (near + far) / (near - far);
        result.m[3][2] = (2.0 * near * far) / (near - far);
        result.m[3][3] = 0.0;

        return result;
    }

    static Mat4 lookAt(Vec3 eye, Vec3 center, Vec3 up)
    {
        Mat4 result = Mat4.zero();

        Vec3 f = Vec3.norm(Vec3.sub(center, eye));
        Vec3 s = Vec3.norm(Vec3.cross(f, up));
        Vec3 u = Vec3.cross(s, f);

        result.m[0][0] = s.x;
        result.m[0][1] = u.x;
        result.m[0][2] = -f.x;

        result.m[1][0] = s.y;
        result.m[1][1] = u.y;
        result.m[1][2] = -f.y;

        result.m[2][0] = s.z;
        result.m[2][1] = u.z;
        result.m[2][2] = -f.z;

        result.m[3][0] = -Vec3.dot(s, eye);
        result.m[3][1] = -Vec3.dot(u, eye);
        result.m[3][2] = Vec3.dot(f, eye);
        result.m[3][3] = 1;

        return result;
    }

    static Mat4 rotate(float angle, Vec3 axis)
    {
        Mat4 result = Mat4.identity;

        axis = Vec3.norm(axis);
        float sinTheta = sin(radians(angle));
        float cosTheta = cos(radians(angle));
        float cosValue = 1.0 - cosTheta;

        result.m[0][0] = (axis.x * axis.x * cosValue) + cosTheta;
        result.m[0][1] = (axis.x * axis.y * cosValue) + (axis.z * sinTheta);
        result.m[0][2] = (axis.x * axis.z * cosValue) - (axis.y * sinTheta);

        result.m[1][0] = (axis.y * axis.x * cosValue) - (axis.z * sinTheta);
        result.m[1][1] = (axis.y * axis.y * cosValue) + cosTheta;
        result.m[1][2] = (axis.y * axis.z * cosValue) + (axis.x * sinTheta);

        result.m[2][0] = (axis.z * axis.x * cosValue) + (axis.y * sinTheta);
        result.m[2][1] = (axis.z * axis.y * cosValue) - (axis.x * sinTheta);
        result.m[2][2] = (axis.z * axis.z * cosValue) + cosTheta;

        return result;
    }

    static Mat4 translate(Vec3 translation)
    {
        Mat4 result = Mat4.identity;

        result.m[3][0] = translation.x;
        result.m[3][1] = translation.y;
        result.m[3][2] = translation.z;

        return result;
    }
}

float radians(float deg)
{
    return deg * (PI / 180.0);
}

unittest
{
    import std.math : isClose;

    // Vec3.zero test
    {
        auto v = Vec3.zero();
        assert(v.x.isClose(0.0));
        assert(v.y.isClose(0.0));
        assert(v.z.isClose(0.0));
    }

}

unittest
{
    import std.math : isClose;

    // Vec3.new test
    {
        auto v = Vec3(1.0, 2.0, 3.0);
        assert(v.x.isClose(1.0));
        assert(v.y.isClose(2.0));
        assert(v.z.isClose(3.0));
    }

}

unittest
{
    import std.math : isClose;

    // Mat4.identity test
    {
        auto m = Mat4.identity();

        foreach (i; 0 .. 4)
        {
            foreach (j; 0 .. 4)
            {
                if (i == j)
                {
                    assert(m.m[i][j].isClose(1.0));
                }
                else
                {
                    assert(m.m[i][j].isClose(0.0));
                }
            }
        }

    }

}
