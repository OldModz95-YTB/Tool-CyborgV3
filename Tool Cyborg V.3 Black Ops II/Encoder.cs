using System;
using System.Text;

internal static class Encoder
{
    private static Encoding DefEncoding = Encoding.GetEncoding("iso-8859-1");

    public static string GetString(byte[] value)
    {
        return global::Encoder.GetString(value, global::Encoder.DefEncoding);
    }

    public static string GetString(byte[] value, Encoding encoding)
    {
        return encoding.GetString(value);
    }

    public static byte[] GetBytes(string value)
    {
        return global::Encoder.GetBytes(value, global::Encoder.DefEncoding);
    }

    public static byte[] GetBytes(string value, Encoding encoding)
    {
        return encoding.GetBytes(value);
    }
}
