import java.util.Scanner;

public class Randcrop {
    public Randcrop(){}
	public static String parse(String line) throws Exception{
		Scanner s = new Scanner(line);
		float prob, height, width;
		int r, g, b;
		try{
			prob = s.nextFloat();
			s.next();
			height = s.nextFloat();
			width = s.nextFloat();
			r = s.nextInt();
			g = s.nextInt();
			b = s.nextInt();
			if(prob > 1 || r > 255 || g > 255 || b > 255 || s.hasNext())
				throw new Exception();
		}
		finally{
			s.close();
		}
		String code = String.format("if(((float)(rand()%%100))/100.0 < %s) tmp = __randcrop(tmp,%s,%s,Scalar(%s,%s,%s));\n", prob, height, width, r, g, b);
		return code;
	}
}
