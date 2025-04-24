import { Button, Space } from 'antd';
import { CopyOutlined, EditOutlined, EyeOutlined } from '@ant-design/icons';
import DeleteButton from '../delete-button';

const ColumnOptions = ({
  isEdit = true,
  isDelete = true,
  isClone = true,
  isShow = true,
  goToEdit = () => {},
  goToClone = () => {},
  goToShow = () => {},
  handleDelete = () => {},
}) => {
  return (
    <Space>
      {isShow && <Button onClick={goToShow} icon={<EyeOutlined />} />}
      {isEdit && (
        <Button type='primary' icon={<EditOutlined />} onClick={goToEdit} />
      )}
      {isClone && <Button icon={<CopyOutlined />} onClick={goToClone} />}
      {isDelete && <DeleteButton onClick={handleDelete} />}
    </Space>
  );
};

export default ColumnOptions;
