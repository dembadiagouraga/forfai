import { RECAPTCHASITEKEY } from "configs/app-global";
import ReCAPTCHA from "react-google-recaptcha";
import { useEffect } from "react";

const Recaptcha = ({ onChange }) => {
  const handleRecaptchaChange = (value) => {
    // Pass the reCAPTCHA response value to the parent component
    onChange(value);
  };

  // Auto-verify recaptcha for development
  useEffect(() => {
    // Simulate successful verification after 1 second
    const timer = setTimeout(() => {
      onChange('development-mode-auto-verified');
    }, 1000);

    return () => clearTimeout(timer);
  }, [onChange]);

  return (
    <div className="recaptcha-container">
      <ReCAPTCHA
        sitekey={RECAPTCHASITEKEY || '6LeIxAcTAAAAAJcZVRqyHh71UMIEGNQ_MXjiZKhI'} // Use test key if not provided
        onChange={handleRecaptchaChange}
      />
    </div>
  );
};

export default Recaptcha;