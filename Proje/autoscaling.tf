resource "aws_launch_configuration" "prdx-launchconf-image" {
  image_id                    = data.aws_ami.amazon.id
  instance_type               = "t2.micro"
  security_groups             = ["${aws_security_group.prdx-proje-sg.id}"]
  associate_public_ip_address = true
  key_name                    = "DevOps14"
  user_data                   = <<EOF
#!/bin/bash
yum install -y httpd php git
cd /var/www/html
sudo wget https://s3-terraform-bucket-lab4.s3.us-east-2.amazonaws.com/itmeme/index-image.html 
sudo wget https://s3-terraform-bucket-lab4.s3.us-east-2.amazonaws.com/itmeme/istockphoto-1124656717-612x612.jpeg
mv index-image.html index.html
mv istockphoto-1124656717-612x612.jpeg itmeme.jpeg
mkdir /var/www/html/itmeme
cp index.html itmeme/
cp /var/www/html/itmeme.jpeg /var/www/html/itmeme
sudo systemctl start httpd
sudo systemctl enable httpd
sudo usermod -a -G apache ec2-user
sudo chown -R ec2-user:apache /var/www
sudo chmod 2775 /var/www && find /var/www -type d -exec sudo chmod 2775 {} \;
find /var/www -type f -exec sudo chmod 0664 {} \;
EOF
}


resource "aws_launch_configuration" "prdx-launchconf-video" {
  image_id                    = data.aws_ami.amazon.id
  instance_type               = "t2.micro"
  security_groups             = ["${aws_security_group.prdx-proje-sg.id}"]
  associate_public_ip_address = true
  key_name                    = "DevOps14"
  user_data                   = <<EOF
#!/bin/bash
yum install -y httpd php git

cd /var/www/html
sudo wget https://s3-terraform-bucket-lab4.s3.us-east-2.amazonaws.com/video/index-animation.html
sudo wget https://s3-terraform-bucket-lab4.s3.us-east-2.amazonaws.com/video/giphy.gif
mv index-animation.html index.html
mv giphy.gif  videos.gif

mkdir /var/www/html/videos
cp index.html videos
cp /var/www/html/videos.gif /var/www/html/videos
sudo systemctl start httpd
sudo systemctl enable httpd
sudo usermod -a -G apache ec2-user
sudo chown -R ec2-user:apache /var/www
sudo chmod 2775 /var/www && find /var/www -type d -exec sudo chmod 2775 {} \;
find /var/www -type f -exec sudo chmod 0664 {} \;
EOF
}
resource "aws_autoscaling_policy" "prdx-policy-image" {
  name                   = "terraform-prdx-image"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  policy_type            = "SimpleScaling"
  autoscaling_group_name = aws_autoscaling_group.aws-auto-scalling.name
}

resource "aws_autoscaling_group" "aws-auto-scalling" {
  name                      = "aws_prdx-image"
  max_size                  = 3
  min_size                  = 1
  health_check_grace_period = 300
  health_check_type         = "EC2"
  desired_capacity          = 1
  force_delete              = true
  launch_configuration      = aws_launch_configuration.prdx-launchconf-image.name
  vpc_zone_identifier       = [aws_subnet.prdx-public1-subnet.id, aws_subnet.prdx-public-subnet.id]
  tag {
    key                 = "Name"
    value               = "Prdx-web14-image"
    propagate_at_launch = true
  }
}
resource "aws_cloudwatch_metric_alarm" "web_cpu_alarm_high_image" {
  alarm_name          = "web_cpu_alarm_high_image1"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "300"
  statistic           = "Average"
  threshold           = "75"
  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.aws-auto-scalling.name
  }
  actions_enabled   = true
  alarm_actions     = [aws_autoscaling_policy.prdx-policy-image.arn]
  alarm_description = "This metric monitors ec2 cpu utilization"
}

resource "aws_cloudwatch_metric_alarm" "web_cpu_alarm_low_image" {
  alarm_name          = "web_cpu_alarm_low_image1"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "300"
  statistic           = "Average"
  threshold           = "20"
  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.aws-auto-scalling.name
  }
  actions_enabled   = true
  alarm_actions     = [aws_autoscaling_policy.prdx-policy-image.arn]
  alarm_description = "This metric monitors ec2 cpu utilization"
}

resource "aws_autoscaling_policy" "prdx-policy-video" {
  name                   = "terraform-prdx-video"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  policy_type            = "SimpleScaling"
  autoscaling_group_name = aws_autoscaling_group.aws-auto-scalling1.name
}

resource "aws_autoscaling_group" "aws-auto-scalling1" {
  name                      = "aws_prdx-video"
  max_size                  = 3
  min_size                  = 1
  health_check_grace_period = 300
  health_check_type         = "EC2"
  desired_capacity          = 1
  force_delete              = true
  launch_configuration      = aws_launch_configuration.prdx-launchconf-video.name
  vpc_zone_identifier       = [aws_subnet.prdx-public1-subnet.id, aws_subnet.prdx-public-subnet.id]
  tag {
    key                 = "Name"
    value               = "Prdx-web24-video"
    propagate_at_launch = true
  }
}
resource "aws_cloudwatch_metric_alarm" "web_cpu_alarm_high_video" {
  alarm_name          = "web_cpu_alarm_high_video1"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "300"
  statistic           = "Average"
  threshold           = "75"
  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.aws-auto-scalling1.name
  }
  actions_enabled   = true
  alarm_actions     = [aws_autoscaling_policy.prdx-policy-video.arn]
  alarm_description = "This metric monitors ec2 cpu utilization"
}

resource "aws_cloudwatch_metric_alarm" "web_cpu_alarm_low_video" {
  alarm_name          = "web_cpu_alarm_low_video1"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "300"
  statistic           = "Average"
  threshold           = "20"
  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.aws-auto-scalling1.name
  }
  actions_enabled   = true
  alarm_actions     = [aws_autoscaling_policy.prdx-policy-video.arn]
  alarm_description = "This metric monitors ec2 cpu utilization"
}

resource "aws_autoscaling_attachment" "asg_attachment_bar" {
  autoscaling_group_name = aws_autoscaling_group.aws-auto-scalling.id
  alb_target_group_arn   = aws_lb_target_group.image.arn
}

resource "aws_autoscaling_attachment" "asg_attachment_bar1" {
  autoscaling_group_name = aws_autoscaling_group.aws-auto-scalling1.id
  alb_target_group_arn   = aws_lb_target_group.video.arn
}