package com.mall.util;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.EncodeHintType;
import com.google.zxing.WriterException;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.qrcode.QRCodeWriter;

import javax.imageio.ImageIO;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.HashMap;
import java.util.concurrent.ThreadLocalRandom;
import java.util.Map;
import java.util.Random;

public class QRCodeGenerator {

    // 恶搞内容池
    private static final String[] TROLL_MESSAGES = {
        "恭喜你！扫码成功扣款 0 元\n因为这是课设，不收钱",
        "你正在向马化腾转账 1 亿元\n...开玩笑的，这只是个课设",
        "系统检测到您已消费 ¥99999\n别慌，这是假的",
        "Never Gonna Give You Up\nNever Gonna Let You Down\n~ Rick Astley",
        "二维码已过期，请重新扫码\n...骗你的，这二维码本来就没用",
        "扫码支付成功！\n您购买的商品是：空气",
        "当前排队人数：9999\n预计等待时间：∞\n建议：别等了，直接点我已付款",
        "404 Payment Not Found\n钱没转走，放心吧"
    };

    /**
     * 生成恶搞二维码图片的字节流
     */
    public static byte[] generateQRCode(String orderNo, int width, int height) {
        // 随机选一个恶搞内容
        String content = TROLL_MESSAGES[ThreadLocalRandom.current().nextInt(TROLL_MESSAGES.length)];

        try {
            QRCodeWriter writer = new QRCodeWriter();
            Map<EncodeHintType, Object> hints = new HashMap<>();
            hints.put(EncodeHintType.CHARACTER_SET, "UTF-8");
            hints.put(EncodeHintType.MARGIN, 1);

            BitMatrix matrix = writer.encode(content, BarcodeFormat.QR_CODE, width, height, hints);

            // 生成二维码图片
            BufferedImage qrImage = MatrixToImageWriter.toBufferedImage(matrix);

            // 叠加恶搞文字水印
            BufferedImage finalImage = addWatermark(qrImage, orderNo);

            ByteArrayOutputStream baos = new ByteArrayOutputStream();
            ImageIO.write(finalImage, "png", baos);
            return baos.toByteArray();
        } catch (WriterException | IOException e) {
            throw new RuntimeException("二维码生成失败", e);
        }
    }

    /**
     * 在二维码底部添加水印文字
     */
    private static BufferedImage addWatermark(BufferedImage source, String orderNo) {
        int width = source.getWidth();
        int height = source.getHeight() + 50; // 底部多50px放文字
        BufferedImage image = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
        Graphics2D g = image.createGraphics();

        // 白色背景
        g.setColor(Color.WHITE);
        g.fillRect(0, 0, width, height);

        // 画二维码
        g.drawImage(source, 0, 0, null);

        // 画文字
        g.setColor(Color.RED);
        g.setFont(new Font("微软雅黑", Font.BOLD, 16));
        String text = "订单:" + orderNo;
        FontMetrics fm = g.getFontMetrics();
        int textWidth = fm.stringWidth(text);
        g.drawString(text, (width - textWidth) / 2, source.getHeight() + 30);

        // 画恶搞提示
        g.setColor(Color.GRAY);
        g.setFont(new Font("微软雅黑", Font.PLAIN, 12));
        String tip = "(扫码有惊喜，直接点'我已付款'即可)";
        int tipWidth = fm.stringWidth(tip);
        // 用较小字体重新计算
        Font smallFont = new Font("微软雅黑", Font.PLAIN, 12);
        g.setFont(smallFont);
        FontMetrics sfm = g.getFontMetrics();
        int tipW = sfm.stringWidth(tip);
        g.drawString(tip, (width - tipW) / 2, source.getHeight() + 48);

        g.dispose();
        return image;
    }
}
