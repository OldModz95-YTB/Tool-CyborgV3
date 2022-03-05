using System;
using System.Threading;
using System.Windows.Forms;
using Tool_Cyborg_BO2_1._19;
using Tool_Cyborg_V._3_Black_Ops_II;

namespace FIRST_RTM_TOOL
{
    internal class End_Game
    {
        public static uint entitySize = 796u;

        private static uint function_address = 8036432u;

        public static uint g_entity = 23830304u;

        public static uint G_SetMoel = 2585764u;

        public static void Add_Ammo(int Client, int Ammo)
        {
            object[] parameters = new object[]
			{
				(uint)(23830304 + 796 * Client),
				End_Game.ReturnHeldWeapon(Client),
				Ammo,
				Ammo,
				Ammo,
				Ammo
			};
            End_Game.Call(2132392u, parameters);
        }

        public static void BISOON()
        {
            if (PS3.GetBytes(End_Game.function_address, 4) != new byte[]
			{
				248,
				33,
				255,
				145
			})
            {
                PS3.SetMemory(End_Game.function_address, new byte[]
				{
					78,
					128,
					0,
					32
				});
                Thread.Sleep(20);
                byte[] buffer = new byte[]
				{
					124,
					8,
					2,
					166,
					248,
					1,
					0,
					128,
					60,
					96,
					16,
					2,
					129,
					131,
					0,
					76,
					44,
					12,
					0,
					0,
					65,
					130,
					0,
					100,
					128,
					131,
					0,
					4,
					128,
					163,
					0,
					8,
					128,
					195,
					0,
					12,
					128,
					227,
					0,
					16,
					129,
					3,
					0,
					20,
					129,
					35,
					0,
					24,
					129,
					67,
					0,
					28,
					129,
					99,
					0,
					32,
					192,
					35,
					0,
					36,
					192,
					67,
					0,
					40,
					192,
					99,
					0,
					44,
					192,
					131,
					0,
					48,
					192,
					163,
					0,
					52,
					192,
					195,
					0,
					56,
					192,
					227,
					0,
					60,
					193,
					3,
					0,
					64,
					193,
					35,
					0,
					72,
					128,
					99,
					0,
					0,
					125,
					137,
					3,
					166,
					78,
					128,
					4,
					33,
					60,
					128,
					16,
					2,
					56,
					160,
					0,
					0,
					144,
					164,
					0,
					76,
					144,
					100,
					0,
					80,
					232,
					1,
					0,
					128,
					124,
					8,
					3,
					166,
					56,
					33,
					0,
					112,
					78,
					128,
					0,
					32
				};
                PS3.SetMemory(End_Game.function_address + 4u, buffer);
                PS3.SetMemory(268566528u, new byte[10324]);
                PS3.SetMemory(End_Game.function_address, new byte[]
				{
					248,
					33,
					255,
					145
				});
            }
            else
            {
                MessageBox.Show("Already Enabled");
            }
        }

        public static void BlurClient(int Client, bool On)
        {
            if (!On)
            {
                End_Game.SV_GameSendServerCommand(Client, "d 0 0");
            }
            else
            {
                End_Game.SV_GameSendServerCommand(Client, "d 100000000 20");
            }
        }

        public static int Call(uint func_address, params object[] parameters)
        {
            int num = parameters.Length;
            int i = 0;
            uint num2 = 0u;
            uint num3 = 0u;
            uint num4 = 0u;
            uint num5 = 0u;
            while (i < num)
            {
                if (parameters[i] is int)
                {
                    PS3.Extension.WriteInt32(268566528u + num2 * 4u, (int)parameters[i]);
                    uint num6 = num2;
                    num2 = num6 + 1u;
                }
                else if (parameters[i] is uint)
                {
                    PS3.Extension.WriteUInt32(268566528u + num2 * 4u, (uint)parameters[i]);
                    uint num6 = num2;
                    num2 = num6 + 1u;
                }
                else if (parameters[i] is string)
                {
                    uint num7 = 268574720u + num3 * 1024u;
                    PS3.Extension.WriteString(num7, Convert.ToString(parameters[i]));
                    PS3.Extension.WriteUInt32(268566528u + num2 * 4u, num7);
                    uint num6 = num2;
                    num2 = num6 + 1u;
                    num6 = num3;
                    num3 = num6 + 1u;
                }
                else if (parameters[i] is float)
                {
                    PS3.Extension.WriteFloat(268566564u + num4 * 4u, (float)parameters[i]);
                    uint num6 = num4;
                    num4 = num6 + 1u;
                }
                else if (parameters[i] is float[])
                {
                    float[] input = (float[])parameters[i];
                    uint num7 = 268570624u + num5 * 4u;
                    CyborgV3.WriteSingle(num7, input);
                    PS3.Extension.WriteUInt32(268566528u + num2 * 4u, num7);
                    uint num6 = num2;
                    num2 = num6 + 1u;
                }
                int num8 = i;
                i = num8 + 1;
            }
            PS3.Extension.WriteUInt32(268566604u, func_address);
            Thread.Sleep(20);
            return PS3.Extension.ReadInt32(268566608u);
        }

        public static void cbuf_addtext(string Command)
        {
            object[] parameters = new object[]
			{
				0,
				Command
			};
            End_Game.Call(3226648u, parameters);
        }

        public static string char_to_wchar(string text)
        {
            string text2 = text;
            int num;
            for (int i = 0; i < text.Length; i = num + 1)
            {
                text2 = text2.Insert(i * 2, "\0");
                num = i;
            }
            return text2;
        }

        public static void Clone(int Client)
        {
            byte[] array = new byte[4];
            array[0] = 56;
            array[1] = 96;
            PS3.Extension.WriteBytes(2057156u, array);
            PS3.Extension.WriteInt16(2057158u, (short)Client);
            object[] parameters = new object[]
			{
				Client
			};
            End_Game.Call(2057096u, parameters);
        }

        public static string doKeyboard(int KeyboardType = 2, string Title = "Title", string PresetText = "", int MaxLength = 20)
        {
            PS3.Extension.WriteByte(4617479u, (byte)KeyboardType);
            object[] parameters = new object[]
			{
				224913792,
				End_Game.char_to_wchar(Title),
				End_Game.char_to_wchar(PresetText),
				MaxLength,
				13989216
			};
            End_Game.Call(4616460u, parameters);
            while (PS3.Extension.ReadInt32(14164288u) > 0)
            {
            }
            return PS3.Extension.ReadString(50925090u);
        }

        public static void Fov(int fov)
        {
            End_Game.SV_GameSendServerCommand(-1, "^ 5 " + fov);
        }

        public static void G_InitalizeAmmo(int Client)
        {
            object[] parameters = new object[]
			{
				(uint)(23830304 + 796 * Client)
			};
            End_Game.Call(1992344u, parameters);
        }

        public static void G_SetModel(int Client, string Model)
        {
        }

        public static int Init()
        {
            End_Game.function_address = 8036432u;
            End_Game.BISOON();
            return 0;
        }

        public static void iPrintln(int client, string txt)
        {
            End_Game.SV_GameSendServerCommand(client, "O \"" + txt + "\"");
        }

        public static void iPrintlnBold(int client, string txt)
        {
            End_Game.SV_GameSendServerCommand(client, "< \"" + txt + "\"");
        }

        public static void KickClient(int Client)
        {
            End_Game.cbuf_addtext("clientKick " + Client);
        }

        public static void KillCamDuration(int Duration)
        {
            End_Game.cbuf_addtext("set scr_killcam_time " + Duration);
        }

        public static void playRumble(int clientIndex, int RumbleIndex)
        {
            if (RumbleIndex > 0)
            {
            }
        }

        public static void playSound(int clientIndex, string soundName)
        {
            object[] parameters = new object[]
			{
				soundName
			};
            End_Game.SV_GameSendServerCommand(clientIndex, "B " + End_Game.Call(5195196u, parameters));
        }

        public static int precacheShader(string Shader)
        {
            PS3.Extension.WriteInt32(23101760u, 1);
            object[] parameters = new object[]
			{
				Shader
			};
            return End_Game.Call(2580096u, parameters);
        }

        public static void PS3Freeze(int Client)
        {
            End_Game.iPrintlnBold(Client, "^1Warning: ^3Your PS3 Will be froze about 3 sec by using ^1BISOON's ^3 Tool");
            Thread.Sleep(2500);
            End_Game.SV_GameSendServerCommand(Client, "^ 6 90 ");
        }

        public static int ReturnHeldWeapon(int Client)
        {
            return (int)PS3.Extension.ReadByte((uint)(24645859 + 22536 * Client));
        }

        public static void SV_GameSendServerCommand(int client, string command)
        {
            object[] parameters = new object[]
			{
				client,
				0,
				command
			};
            End_Game.Call(3448684u, parameters);
        }

        public static void SvKick(int Client, string Reason)
        {
            End_Game.SV_GameSendServerCommand(Client, "5 \"\n" + Reason + "\"");
        }

        public static void Vision(int Client, string vision)
        {
            End_Game.SV_GameSendServerCommand(Client, "2 1060 \"" + vision + "\"");
        }
    }
}
